"""
Image management for StudyCompanion add-on.
Handles image file selection, deletion, and cycle state.
"""

import os
import json
import random
from aqt import mw
from aqt.utils import showInfo


# Supported image extensions
VALID_EXT = (".png", ".jpg", ".jpeg", ".gif", ".webp", ".bmp", ".tiff", ".svg")

# Cycle state: file set from last scan and remaining list
_cycle_known_set: set[str] = set()
_cycle_remaining: list[str] = []
_cycle_state_path: str | None = None
_last_filename: str | None = None


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
        print(f"[StudyCompanion] Failed to save cycle state: {e}")


def sanitize_folder_name(name: str) -> str:
    """
    Normalize a collection.media subfolder name.
    - Empty => study_companion_images
    - Reject absolute/parent-like references
    """
    s = (name or "").strip()
    if not s:
        return "study_companion_images"

    s = s.replace("\\", "/")

    if s.startswith(("/", "~")) or ":" in s or ".." in s:
        showInfo("Invalid folder name. Please use a simple subfolder name, e.g. study_companion_images")
        return "study_companion_images"

    s = s.strip("/")

    if not s:
        return "study_companion_images"
    return s


def get_media_subfolder_path(folder_name: str) -> str | None:
    """Get the full path to a media subfolder."""
    col = getattr(mw, "col", None)
    if not col:
        return None
    media_dir = col.media.dir()
    return os.path.join(media_dir, folder_name)


def open_images_folder(folder_name: str | None = None) -> None:
    """Ensure collection.media/<folder_name> exists and open it."""
    from aqt.utils import openFolder
    
    if folder_name is None:
        from .config_manager import get_config
        cfg = get_config()
        folder_name = cfg.get("folder_name", "study_companion_images")

    folder_name = sanitize_folder_name(str(folder_name))
    path = get_media_subfolder_path(folder_name)
    if not path:
        showInfo("No collection is open.")
        return

    os.makedirs(path, exist_ok=True)
    openFolder(path)


def delete_image_file(filename: str, cfg: dict) -> bool:
    """Delete an image file and remove it from cycle state. Returns True if successful."""
    global _cycle_known_set, _cycle_remaining, _cycle_state_path
    try:
        col = getattr(mw, "col", None)
        if not col:
            return False

        folder_name = sanitize_folder_name(cfg.get("folder_name", "study_companion_images"))
        image_folder = get_media_subfolder_path(folder_name)
        if not image_folder:
            return False

        file_path = os.path.join(image_folder, filename)
        if os.path.exists(file_path):
            os.remove(file_path)

        if filename in _cycle_known_set:
            _cycle_known_set.discard(filename)
            if filename in _cycle_remaining:
                _cycle_remaining.remove(filename)

        if _cycle_state_path:
            _save_cycle_state(_cycle_state_path, _cycle_known_set, _cycle_remaining)

        return True
    except Exception as e:
        print(f"[StudyCompanion] Error deleting image: {e}")
        return False


def pick_random_image_filenames(cfg: dict, count: int) -> list[str] | None:
    """Return a list of up to `count` filenames from the media folder."""
    global _last_filename, _cycle_known_set, _cycle_remaining, _cycle_state_path
    try:
        col = getattr(mw, "col", None)
        if not col:
            return None

        folder_name = sanitize_folder_name(cfg.get("folder_name", "study_companion_images"))
        image_folder = get_media_subfolder_path(folder_name)
        if not image_folder:
            return None

        if not os.path.isdir(image_folder):
            return None

        # Collect image files recursively
        files = []
        for root, dirs, filenames in os.walk(image_folder):
            for filename in filenames:
                if filename.lower().endswith(VALID_EXT):
                    rel_path = os.path.relpath(os.path.join(root, filename), image_folder)
                    rel_path = rel_path.replace("\\", "/")
                    files.append(rel_path)

        if not files:
            return None

        result = []

        if cfg.get("avoid_repeat", True):
            files_set = set(files)
            state_path = os.path.join(image_folder, ".study_companion_cycle.json")

            if _cycle_state_path != state_path:
                _cycle_known_set, _cycle_remaining = _load_cycle_state(state_path)
                _cycle_state_path = state_path

            if not _cycle_remaining or files_set != _cycle_known_set:
                already_seen = _cycle_known_set - set(_cycle_remaining)
                already_seen &= files_set

                remaining_candidates = list(files_set - already_seen)
                if not remaining_candidates:
                    remaining_candidates = list(files_set)
                random.shuffle(remaining_candidates)

                _cycle_known_set = files_set
                _cycle_remaining = remaining_candidates

            while len(result) < count:
                if not _cycle_remaining:
                    _cycle_remaining = list(_cycle_known_set)
                    random.shuffle(_cycle_remaining)
                result.append(_cycle_remaining.pop())

            _save_cycle_state(state_path, _cycle_known_set, _cycle_remaining)
        else:
            if count <= len(files):
                result = random.sample(files, count)
            else:
                result = files[:]
                random.shuffle(result)
                while len(result) < count:
                    result.append(random.choice(files))

        if result:
            _last_filename = result[-1]
        return result
    except Exception as e:
        print(f"[StudyCompanion] Error while picking images: {e}")
        return None
