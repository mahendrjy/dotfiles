"""
StudyCompanion - An extensible Anki add-on for enhanced study sessions.

Features:
- Display random images during reviews
- Show motivational quotes
- Optional website embedding (desktop/mobile modes)
- Background audio playback
- Flexible configuration

Main entry point that registers hooks and initializes the add-on.
"""

from aqt import gui_hooks, mw

from .config_manager import get_config
from .image_manager import delete_image_file
from .ui_manager import register_config_action, register_tools_menu
from .audio_manager import setup_audio_player
from .features import inject_random_image


def _handle_webview_message(handled, message, context):
    """Handle delete image command from JavaScript."""
    if isinstance(message, str) and message.startswith("randomImageDelete:"):
        filename = message[len("randomImageDelete:"):]
        cfg = get_config()
        if delete_image_file(filename, cfg):
            # Re-render the card without doing a full webview reload
            if hasattr(mw, "reviewer") and mw.reviewer:
                reviewer = mw.reviewer
                try:
                    if hasattr(reviewer, "card") and reviewer.card:
                        try:
                            reviewer._showQuestion()
                        except Exception:
                            try:
                                reviewer._showAnswer()
                            except Exception:
                                if hasattr(reviewer, "web") and reviewer.web:
                                    try:
                                        reviewer.web.eval("location.reload();")
                                    except Exception:
                                        pass
                    else:
                        if hasattr(reviewer, "web") and reviewer.web:
                            try:
                                reviewer.web.eval("location.reload();")
                            except Exception:
                                pass
                except Exception:
                    pass
        return (True, None)
    return handled


def _on_main_window_init():
    """Initialize StudyCompanion when main window is ready."""
    # Register config action
    register_config_action()
    
    # Add menu item to Tools menu
    register_tools_menu()

    # Setup background audio on startup
    try:
        setup_audio_player(get_config())
    except Exception as e:
        print(f"[StudyCompanion] Failed to setup audio: {e}")


# ============================================================================
# Register Hooks
# ============================================================================

# Initialize when main window is ready
gui_hooks.main_window_did_init.append(_on_main_window_init)

# Inject images/quotes/website into card display
gui_hooks.card_will_show.append(inject_random_image)

# Handle delete image messages from JavaScript
gui_hooks.webview_did_receive_js_message.append(_handle_webview_message)
