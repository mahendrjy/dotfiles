import os
import json
import re
import random
import html

from aqt import gui_hooks, mw
from aqt.utils import openFolder, showInfo
from aqt.qt import (
    QAction,
    QDialog, QVBoxLayout, QFormLayout, QHBoxLayout,
    QCheckBox, QLineEdit, QSpinBox, QPushButton,
    QDialogButtonBox, QLabel, QWidget,
    qconnect,
)

# Supported image extensions
VALID_EXT = (".png", ".jpg", ".jpeg", ".gif")

# Last filename shown (for avoid_repeat legacy logic)
_last_filename = None
# Cycle state: file set from last scan and remaining list
_cycle_known_set: set[str] = set()
_cycle_remaining: list[str] = []
_cycle_state_path: str | None = None


def _load_cycle_state(state_path: str):
    """Load persisted cycle state; if missing/corrupt, return empty."""
    try:
        with open(state_path, "r", encoding="utf-8") as f:
            data = json.load(f)
        known = set(data.get("known", []))
        remaining = data.get("remaining", [])
        return known, remaining
    except Exception:
        return set(), []


def _save_cycle_state(state_path: str, known: set[str], remaining: list[str]):
    """Persist cycle state (failure is non-fatal)."""
    try:
        tmp_path = state_path + ".tmp"
        with open(tmp_path, "w", encoding="utf-8") as f:
            json.dump({"known": sorted(list(known)), "remaining": remaining}, f, ensure_ascii=False)
        os.replace(tmp_path, state_path)
    except Exception as e:
        print("[RandomImageAddon] Failed to save cycle state:", e)


def _defaults() -> dict:
    return {
        "enabled": True,
        "show_on_question": True,
        "show_on_answer": True,
        "folder_name": "random_images",
        "max_width_percent": 80,
        "max_height_vh": 60,
        "avoid_repeat": True,
        "show_filename": True,
    }


def get_config() -> dict:
    """Load config.json; fall back to defaults on failure."""
    default = _defaults()
    try:
        cfg = mw.addonManager.getConfig(__name__)
        if not isinstance(cfg, dict):
            return default
        return {**default, **cfg}
    except Exception as e:
        print("[RandomImageAddon] Failed to load config:", e)
        return default


def _write_config(new_cfg: dict) -> None:
    """Save config while keeping unknown keys untouched."""
    try:
        old = mw.addonManager.getConfig(__name__)
        if not isinstance(old, dict):
            old = {}
        merged = {**old, **new_cfg}  # 既存の未知キーは残しつつ、GUI項目だけ更新
        mw.addonManager.writeConfig(__name__, merged)
    except Exception as e:
        print("[RandomImageAddon] Failed to write config:", e)


def _sanitize_folder_name(name: str) -> str:
    """
    Normalize a collection.media subfolder name.
    - Empty => random_images
    - Reject absolute/parent-like references
    """
    s = (name or "").strip()
    if not s:
        return "random_images"

    # Normalize Windows backslash to slash for consistency
    s = s.replace("\\", "/")

    # Block obvious absolute/parent references
    if s.startswith(("/", "~")) or ":" in s or ".." in s:
        showInfo("Invalid folder name. Please use a simple subfolder name, e.g. random_images")
        return "random_images"

    # Strip trailing slash
    s = s.strip("/")

    if not s:
        return "random_images"
    return s


def _media_subfolder_path(folder_name: str) -> str | None:
    col = getattr(mw, "col", None)
    if not col:
        return None
    media_dir = col.media.dir()
    return os.path.join(media_dir, folder_name)


def open_images_folder(folder_name: str | None = None) -> None:
    """Ensure collection.media/<folder_name> exists and open it."""
    if folder_name is None:
        cfg = get_config()
        folder_name = cfg.get("folder_name", "random_images")

    folder_name = _sanitize_folder_name(str(folder_name))
    path = _media_subfolder_path(folder_name)
    if not path:
        showInfo("No collection is open.")
        return

    os.makedirs(path, exist_ok=True)
    openFolder(path)


class RandomImageSettingsDialog(QDialog):
    """Settings dialog (keeps config keys compatible; no extra Tools menu)."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Random Image Settings")
        self.setMinimumWidth(480)

        cfg = get_config()

        root = QVBoxLayout(self)

        desc = QLabel(
            "Settings are saved to config.json.\n"
            "They apply the next time a card is shown."
        )
        desc.setWordWrap(True)
        root.addWidget(desc)

        form = QFormLayout()
        root.addLayout(form)

        # enabled
        self.cb_enabled = QCheckBox("Enable add-on")
        self.cb_enabled.setChecked(bool(cfg.get("enabled", True)))
        form.addRow(self.cb_enabled)

        # show_on_question / answer
        self.cb_q = QCheckBox("Show on Question side")
        self.cb_q.setChecked(bool(cfg.get("show_on_question", True)))
        form.addRow(self.cb_q)

        self.cb_a = QCheckBox("Show on Answer side")
        self.cb_a.setChecked(bool(cfg.get("show_on_answer", True)))
        form.addRow(self.cb_a)

        # folder_name + open button
        self.le_folder = QLineEdit(str(cfg.get("folder_name", "random_images")))
        self.le_folder.setPlaceholderText("random_images")

        btn_open = QPushButton("Open folder")
        qconnect(btn_open.clicked, self._on_open_folder)

        folder_row = QWidget()
        folder_layout = QHBoxLayout(folder_row)
        folder_layout.setContentsMargins(0, 0, 0, 0)
        folder_layout.addWidget(self.le_folder, 1)
        folder_layout.addWidget(btn_open)

        form.addRow("Image folder (inside collection.media)", folder_row)

        # max_width_percent
        self.sp_w = QSpinBox()
        self.sp_w.setRange(0, 100)  # 0 = no limit
        self.sp_w.setValue(int(cfg.get("max_width_percent", 80) or 0))
        self.sp_w.setSuffix(" %")
        form.addRow("Max width", self.sp_w)

        # max_height_vh
        self.sp_h = QSpinBox()
        self.sp_h.setRange(0, 200)  # 0 = no limit
        self.sp_h.setValue(int(cfg.get("max_height_vh", 60) or 0))
        self.sp_h.setSuffix(" vh")
        form.addRow("Max height", self.sp_h)

        # avoid_repeat
        self.cb_avoid = QCheckBox("Avoid showing the same image twice in a row")
        self.cb_avoid.setChecked(bool(cfg.get("avoid_repeat", True)))
        form.addRow(self.cb_avoid)

        # show_filename
        self.cb_fn = QCheckBox("Show filename caption")
        self.cb_fn.setChecked(bool(cfg.get("show_filename", True)))
        form.addRow(self.cb_fn)

        # Buttons
        buttons = QDialogButtonBox(
            QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel
        )

        # Reset to defaults (add manually for older Anki/PyQt lacking StandardButton)
        btn_reset = QPushButton("Reset to defaults")
        buttons.addButton(btn_reset, QDialogButtonBox.ButtonRole.ResetRole)
        qconnect(btn_reset.clicked, self._on_reset)

        qconnect(buttons.accepted, self._on_ok)
        qconnect(buttons.rejected, self.reject)
        root.addWidget(buttons)

    def _on_open_folder(self):
        folder = _sanitize_folder_name(self.le_folder.text())
        self.le_folder.setText(folder)
        open_images_folder(folder)

    def _on_ok(self):
        folder = _sanitize_folder_name(self.le_folder.text())
        self.le_folder.setText(folder)

        new_cfg = {
            "enabled": bool(self.cb_enabled.isChecked()),
            "show_on_question": bool(self.cb_q.isChecked()),
            "show_on_answer": bool(self.cb_a.isChecked()),
            "folder_name": folder,
            "max_width_percent": int(self.sp_w.value()),
            "max_height_vh": int(self.sp_h.value()),
            "avoid_repeat": bool(self.cb_avoid.isChecked()),
            "show_filename": bool(self.cb_fn.isChecked()),
        }
        _write_config(new_cfg)
        self.accept()

    def _on_reset(self):
        d = _defaults()

        self.cb_enabled.setChecked(bool(d.get("enabled", True)))
        self.cb_q.setChecked(bool(d.get("show_on_question", True)))
        self.cb_a.setChecked(bool(d.get("show_on_answer", True)))

        self.le_folder.setText(str(d.get("folder_name", "random_images")))

        self.sp_w.setValue(int(d.get("max_width_percent", 80) or 0))
        self.sp_h.setValue(int(d.get("max_height_vh", 60) or 0))

        self.cb_avoid.setChecked(bool(d.get("avoid_repeat", True)))
        self.cb_fn.setChecked(bool(d.get("show_filename", True)))



def open_settings_dialog(*args, **kwargs):
    """
    Expected to be invoked from the Add-ons "Config" button.
    Accepts *args/**kwargs so different call styles still work.
    """
    parent = kwargs.get("parent", None)
    if parent is None and args:
        parent = args[0]
    parent = parent or mw

    dlg = RandomImageSettingsDialog(parent=parent)
    dlg.exec()


def delete_image_file(filename: str, cfg: dict) -> bool:
    """Delete an image file and remove it from cycle state. Returns True if successful."""
    global _cycle_known_set, _cycle_remaining, _cycle_state_path
    try:
        col = getattr(mw, "col", None)
        if not col:
            return False

        folder_name = _sanitize_folder_name(cfg.get("folder_name", "random_images"))
        image_folder = _media_subfolder_path(folder_name)
        if not image_folder:
            return False

        # Build full path to the file
        file_path = os.path.join(image_folder, filename)
        if os.path.exists(file_path):
            os.remove(file_path)

        # Remove from cycle state if it exists
        if filename in _cycle_known_set:
            _cycle_known_set.discard(filename)
            if filename in _cycle_remaining:
                _cycle_remaining.remove(filename)

        # Save updated state
        if _cycle_state_path:
            _save_cycle_state(_cycle_state_path, _cycle_known_set, _cycle_remaining)

        return True
    except Exception as e:
        print("[RandomImageAddon] Error deleting image:", e)
        return False


def pick_random_image_filename(cfg: dict):
    """Return a random filename from collection.media/<folder_name>/ (recurses subfolders)."""
    global _last_filename, _cycle_known_set, _cycle_remaining, _cycle_state_path
    try:
        col = getattr(mw, "col", None)
        if not col:
            return None

        folder_name = _sanitize_folder_name(cfg.get("folder_name", "random_images"))
        image_folder = _media_subfolder_path(folder_name)
        if not image_folder:
            return None

        if not os.path.isdir(image_folder):
            # If the folder is missing, treat as "no images" (do not auto-create)
            return None

        # Collect image files recursively, including subfolders
        files = []
        for root, dirs, filenames in os.walk(image_folder):
            for filename in filenames:
                if filename.lower().endswith(VALID_EXT):
                    # Keep path relative to folder_name
                    rel_path = os.path.relpath(os.path.join(root, filename), image_folder)
                    # Normalize Windows backslash to slash
                    rel_path = rel_path.replace("\\", "/")
                    files.append(rel_path)

        if not files:
            return None

        # avoid_repeat: cover all images once per cycle; state is persisted
        if cfg.get("avoid_repeat", True):
            files_set = set(files)

            # Cycle state file (hidden file inside media folder)
            state_path = os.path.join(image_folder, ".random_image_cycle.json")

            # Load state if first run or folder changed
            if _cycle_state_path != state_path:
                _cycle_known_set, _cycle_remaining = _load_cycle_state(state_path)
                _cycle_state_path = state_path

            # If files changed, rebuild remaining list, keeping already-seen items excluded
            if not _cycle_remaining or files_set != _cycle_known_set:
                already_seen = _cycle_known_set - set(_cycle_remaining)
                already_seen &= files_set  # Keep only files that still exist

                remaining_candidates = list(files_set - already_seen)
                if not remaining_candidates:
                    # If everything was shown, start a new cycle
                    remaining_candidates = list(files_set)
                random.shuffle(remaining_candidates)

                _cycle_known_set = files_set
                _cycle_remaining = remaining_candidates

            filename = _cycle_remaining.pop()

            # Persist so restart resumes the same cycle
            _save_cycle_state(state_path, _cycle_known_set, _cycle_remaining)
        else:
            filename = random.choice(files)

        _last_filename = filename
        return filename
    except Exception as e:
        print("[RandomImageAddon] Error while picking image:", e)
        return None


def inject_random_image(text: str, card, kind: str) -> str:
    """
    Hook for card_will_show.
    kind: "reviewQuestion", "reviewAnswer", etc.
    """
    cfg = get_config()

    if not cfg.get("enabled", True):
        return text

    if kind.endswith("Question") and not cfg.get("show_on_question", True):
        return text
    if kind.endswith("Answer") and not cfg.get("show_on_answer", True):
        return text

    filename = pick_random_image_filename(cfg)
    if not filename:
        return text

    folder_name = _sanitize_folder_name(cfg.get("folder_name", "random_images"))
    img_src = f"{folder_name}/{filename}"

    # Hover tooltip: show original filename (escape for HTML attribute safety)
    title_attr = html.escape(filename, quote=True)
    filename_escaped = html.escape(filename, quote=True)

    max_w = cfg.get("max_width_percent", 80)
    max_h = cfg.get("max_height_vh", 60)

    style_parts = []
    if isinstance(max_w, (int, float)) and max_w > 0:
        style_parts.append(f"max-width:{max_w}%")
    if isinstance(max_h, (int, float)) and max_h > 0:
        style_parts.append(f"max-height:{max_h}vh")
    style_parts.append("border-radius:8px")

    style_attr = "; ".join(style_parts)

    caption_html = ""
    if cfg.get("show_filename", True):
        base_name = os.path.splitext(filename)[0]
        base_name = base_name.replace("-", " ").replace("_", " ")
        base_name = re.sub(r"\d+", "", base_name)
        base_name = re.sub(r"\s+", " ", base_name).strip()
        base_name = base_name.upper()

        caption_html = f"""
  <div style="margin-top:6px; font-size:0.9em; color:#888;">
    {base_name}
  </div>
"""

    delete_button_html = f"""
  <button 
    onclick="deleteRandomImage('{filename_escaped}')" 
    style="margin-top:8px; padding:6px 12px; background-color:#dc3545; color:white; border:none; border-radius:4px; cursor:pointer; font-size:0.85em;"
    title="Delete this image"
  >
    Delete Image
  </button>
"""

    extra_html = f"""
<div style="text-align:center; margin-top:15px;" id="random-image-container">
  <img src="{img_src}" style="{style_attr}" title="{title_attr}">
{caption_html}{delete_button_html}</div>
<script>
(function() {{
    function deleteRandomImage(filename) {{
        if (confirm('Delete this image?')) {{
            if (typeof pycmd !== 'undefined') {{
                pycmd('randomImageDelete:' + filename);
            }} else if (typeof window.pycmd !== 'undefined') {{
                window.pycmd('randomImageDelete:' + filename);
            }}
        }}
    }}
    window.deleteRandomImage = deleteRandomImage;
}})();
</script>
"""
    return text + extra_html


def _register_config_action() -> None:
    """
    Wire the Add-ons "Config" button to open this GUI.
    """
    try:
        mw.addonManager.setConfigAction(__name__, open_settings_dialog)
        print("[RandomImageAddon] Config action registered.")
    except Exception as e:
        # Fallback for old Anki without setConfigAction: add to Tools as a last resort
        print("[RandomImageAddon] setConfigAction not available:", e)
        try:
            menu = getattr(mw.form, "menuTools", None) or getattr(mw.form, "toolsMenu", None)
            if menu is not None:
                act = QAction("Random Image Settings…", mw)
                qconnect(act.triggered, open_settings_dialog)
                menu.addAction(act)
        except Exception as e2:
            print("[RandomImageAddon] Fallback menu failed:", e2)


def _handle_webview_message(handled, message, context):
    """Handle delete image command from JavaScript."""
    if isinstance(message, str) and message.startswith("randomImageDelete:"):
        filename = message[len("randomImageDelete:"):]
        cfg = get_config()
        if delete_image_file(filename, cfg):
            # Refresh the card to show a new image
            if hasattr(mw, "reviewer") and mw.reviewer:
                reviewer = mw.reviewer
                # Reload the webview to trigger card_will_show hook again
                # This will pick a new random image
                if hasattr(reviewer, "web") and reviewer.web:
                    try:
                        reviewer.web.eval("location.reload();")
                    except Exception:
                        # Fallback: try to show question side if card exists
                        if hasattr(reviewer, "card") and reviewer.card:
                            try:
                                reviewer._showQuestion()
                            except AttributeError:
                                pass
        return (True, None)
    return handled


def _on_main_window_init():
    _register_config_action()


# Register after main window init
gui_hooks.main_window_did_init.append(_on_main_window_init)

# Hook card display
gui_hooks.card_will_show.append(inject_random_image)

# Hook webview messages for delete functionality
gui_hooks.webview_did_receive_js_message.append(_handle_webview_message)
