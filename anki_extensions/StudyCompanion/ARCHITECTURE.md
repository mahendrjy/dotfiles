# StudyCompanion Architecture Guide

## Overview

StudyCompanion is a modular, extensible Anki add-on designed to enhance the study experience with images, quotes, websites, and audio. The codebase is organized into focused modules that can be easily extended with new features.

## Module Structure

```
studycompanion/
├── __init__.py                  # Main entry point, hook registration
├── config_manager.py            # Configuration loading/saving
├── image_manager.py             # Image selection, deletion, cycle state
├── quotes.py                    # Quote management
├── audio_manager.py             # Audio playback control
├── ui_manager.py                # UI components (settings dialog, menu)
└── features.py                  # Core features (image injection, rendering)
```

## Module Responsibilities

### `__init__.py` - Main Entry Point
- Registers all Anki hooks
- Initializes the add-on on startup
- Routes webview messages

**Key Functions:**
- `_on_main_window_init()`: Called when Anki launches
- `_handle_webview_message()`: Routes JavaScript callbacks

### `config_manager.py` - Configuration
Manages all add-on settings and persistence.

**Key Functions:**
- `get_defaults()`: Returns default configuration values
- `get_config()`: Loads current config with backwards compatibility
- `write_config()`: Saves settings to config.json

**Key Configuration Options:**
```python
{
    "enabled": bool,
    "show_on_question": bool,
    "show_on_answer": bool,
    "folder_name": str,
    "images_to_show": int,
    "avoid_repeat": bool,
    "show_motivation_quotes": bool,
    "website_url": str,
    "website_display_mode": str,  # "desktop" or "mobile"
    "audio_file_path": str,
    "audio_volume": int (0-100),
}
```

### `image_manager.py` - Image Handling
Manages image file selection, deletion, and rotation cycle.

**Key Functions:**
- `pick_random_image_filenames()`: Select random images from folder
- `delete_image_file()`: Delete image and update cycle state
- `get_media_subfolder_path()`: Get path to image folder
- `open_images_folder()`: Open image folder in file manager
- `sanitize_folder_name()`: Validate folder names

**Features:**
- Supports recursive subdirectories
- Avoid-repeat cycle: shows all images before repeating
- Persistent cycle state in `.study_companion_cycle.json`
- Supports: PNG, JPG, GIF, WebP, BMP, TIFF, SVG

### `quotes.py` - Motivational Quotes
Manages quote selection and display.

**Key Functions:**
- `get_random_quote()`: Get single random quote
- `get_unique_random_quotes()`: Get list of unique quotes
- `_get_builtin_quotes()`: Built-in quote collection (200+)

**Features:**
- Loads from local `quotes.txt` file first
- Falls back to built-in quotes
- Caches quotes in memory for performance
- Can generate unique quotes per card

### `audio_manager.py` - Background Audio
Manages audio playback during study sessions.

**Key Functions:**
- `setup_audio_player()`: Initialize and start audio
- `stop_audio()`: Stop playback

**Features:**
- Uses PyQt6 QMediaPlayer
- Supports: MP3, WAV, FLAC, AAC, OGG
- Infinite looping
- Volume control (0-100%)

### `ui_manager.py` - User Interface
Provides settings UI and menu integration.

**Key Classes:**
- `SettingsDialog`: QDialog with all configuration options

**Key Functions:**
- `open_settings_dialog()`: Launch settings dialog
- `register_config_action()`: Register with Anki's config system
- `register_tools_menu()`: Add menu item to Tools menu

### `features.py` - Core Features
Implements the main card rendering logic with images, quotes, and websites.

**Key Functions:**
- `inject_random_image()`: Anki hook that adds content to cards
- `_build_quote_delete_row()`: Generate quote + delete button HTML
- `_create_website_cell()`: Generate website cell for mobile mode
- `_build_desktop_website()`: Generate full-width website section

**Features:**
- Responsive grid layout (max 3 columns)
- Object-fit cover for images (centered crop)
- Per-item unique quotes
- Website persistence across card flips
- Mobile/desktop layout modes
- Delete button with immediate feedback

## Extending StudyCompanion

### Adding a New Feature Module

1. **Create a new module** (e.g., `new_feature.py`):
```python
"""
New Feature description for StudyCompanion.
"""

def init_new_feature(cfg: dict) -> None:
    """Initialize the new feature."""
    pass

def some_feature_function() -> str:
    """Do something useful."""
    return "result"
```

2. **Import in `__init__.py`**:
```python
from .new_feature import init_new_feature

def _on_main_window_init():
    # ... existing code ...
    init_new_feature(get_config())
```

3. **Test and validate**

### Adding a Configuration Option

1. **Add to `config_manager.py`** `get_defaults()`:
```python
def get_defaults() -> dict:
    return {
        # ... existing keys ...
        "new_option": default_value,
    }
```

2. **Add UI control in `ui_manager.py`** `SettingsDialog`:
```python
self.cb_new_option = QCheckBox("New Option")
self.cb_new_option.setChecked(bool(cfg.get("new_option", True)))
form.addRow(self.cb_new_option)

# In _on_ok():
new_cfg = {
    # ... existing keys ...
    "new_option": self.cb_new_option.isChecked(),
}
```

3. **Use in features** by accessing `get_config()`

### Adding a New Hook

1. **Create handler function** in appropriate module
2. **Register in `__init__.py`**:
```python
from aqt import gui_hooks

gui_hooks.some_hook.append(handler_function)
```

### Adding a New Card Feature

Modify `features.py` `inject_random_image()`:

```python
def inject_random_image(text: str, card, kind: str) -> str:
    # ... existing code ...
    
    # Add new feature
    new_feature_html = _build_new_feature(cfg)
    
    extra_html = f"""
        {website_html}
        {new_feature_html}
        <div>Images and other existing content</div>
    """
    return text + extra_html

def _build_new_feature(cfg: dict) -> str:
    """Generate HTML for new feature."""
    if not cfg.get("new_feature_enabled"):
        return ""
    return "<div>Your new feature HTML</div>"
```

## Adding New Motivational Quotes

### Method 1: Edit `quotes.txt` (Recommended)
Create a `quotes.txt` file in the add-on folder with one quote per line:

```
Your first motivational quote
Another inspiring message
Yet another quote
```

The module will automatically load these before built-in quotes.

### Method 2: Extend `_get_builtin_quotes()` in `quotes.py`
Add quotes directly to the `_get_builtin_quotes()` function:

```python
def _get_builtin_quotes() -> list[str]:
    return [
        # ... existing quotes ...
        "Your new quote here",
        "Another quote",
    ]
```

## Testing Your Changes

### Python Syntax Check
```bash
python3 -m py_compile module_name.py
```

### Import Check
```bash
cd /path/to/addon
python3 -c "from config_manager import get_config; print(get_config())"
```

### Configuration Validation
Ensure all keys in `get_defaults()` are handled in UI and used in features.

## Performance Considerations

1. **Quotes**: Cached in memory after first access
2. **Images**: Cycle state persisted to disk, loaded once per folder change
3. **Audio**: Player created once, reused across sessions
4. **Website**: DOM node preserved in JavaScript to avoid reloading

## Compatibility

- **Anki**: 2.1+
- **Python**: 3.10+
- **PyQt6**: 6.0+

## Common Issues & Solutions

### Images not showing
- Check folder name in settings
- Ensure images exist in `collection.media/<folder_name>/`
- Verify image format is supported

### Website not persisting
- Enable website URL in settings
- Use HTTPS URLs (some websites block HTTP in iframes)
- Check browser console for CORS errors

### Audio not playing
- Verify audio file path is correct
- Ensure audio format is supported
- Check system audio is working

### Quotes not appearing
- Verify `show_motivation_quotes` is enabled
- Check `quotes.txt` exists if using custom quotes
- Verify quote list is not empty

## Code Style Guidelines

- Follow PEP 8
- Use type hints
- Add docstrings to all functions
- Keep functions focused and testable
- Use descriptive variable names
- Add comments for complex logic

## License

[Same as original add-on]
