# StudyCompanion Developer Guide

## Quick Start

### Understanding the Flow

1. **Startup** → `_on_main_window_init()` initializes audio & UI
2. **Card Display** → `inject_random_image()` adds content
3. **User Clicks Delete** → JavaScript triggers `randomImageDelete:` message
4. **Image Deleted** → `_handle_webview_message()` processes deletion

### Module Dependency Graph

```
__init__.py
├── config_manager.py
├── ui_manager.py
│   ├── config_manager.py
│   ├── image_manager.py
│   └── audio_manager.py
├── features.py
│   ├── config_manager.py
│   ├── image_manager.py
│   └── quotes.py
├── image_manager.py
│   └── config_manager.py
└── audio_manager.py
```

### Key Entry Points for Modification

#### 1. Add a new configuration option
**File**: `config_manager.py` + `ui_manager.py`

```python
# config_manager.py
def get_defaults() -> dict:
    return {
        ...
        "my_new_option": True,
    }

# ui_manager.py - SettingsDialog.__init__()
self.cb_my_option = QCheckBox("My New Option")
self.cb_my_option.setChecked(bool(cfg.get("my_new_option", True)))
form.addRow(self.cb_my_option)

# SettingsDialog._on_ok()
"my_new_option": bool(self.cb_my_option.isChecked()),
```

#### 2. Add a new card rendering element
**File**: `features.py`

```python
def inject_random_image(text: str, card, kind: str) -> str:
    # ... existing code ...
    
    # Add your element
    my_element = _build_my_element(cfg)
    
    extra_html += my_element
    return text + extra_html
```

#### 3. Add a new Anki hook
**File**: `__init__.py`

```python
from aqt import gui_hooks

def my_hook_handler(*args, **kwargs):
    print("Hook triggered!")

gui_hooks.some_hook_name.append(my_hook_handler)
```

## Testing Scenarios

### Scenario 1: Image Deletion
1. Open Anki and review a card with images
2. Click the 🗑️ delete button
3. Verify image disappears without page reload
4. Verify other add-ons still visible

### Scenario 2: Multiple Images
1. Set "Number of images to show" to 3+
2. Review a card
3. Verify images appear in grid (max 3 per row)
4. Verify each image has its own delete button
5. Verify quotes are unique per image

### Scenario 3: Website Display
1. Set Website URL to a valid HTTPS site
2. Set display mode to "Mobile"
3. Review a card with images
4. Verify website appears in grid (first row, middle)
5. Flip to answer and back
6. Verify website persists without reloading
7. Switch to "Desktop" mode
8. Verify website appears full-width above images

### Scenario 4: Background Audio
1. Set audio file path to a valid MP3
2. Set volume to 50%
3. Restart Anki
4. Verify audio plays in background
5. Play multiple cards
6. Verify audio loops continuously
7. Adjust volume in settings
8. Verify volume changes without restart

### Scenario 5: Quotes
1. Enable "Show motivational quote below image"
2. Create custom `quotes.txt` file
3. Restart Anki
4. Review cards
5. Verify quotes from custom file appear
6. Verify each image gets different quote

## Common Extension Patterns

### Pattern 1: Adding a Simple Toggle Option

```python
# 1. Add to config defaults
"my_feature_enabled": False,

# 2. Add to UI
self.cb_my_feature = QCheckBox("Enable My Feature")
self.cb_my_feature.setChecked(bool(cfg.get("my_feature_enabled")))
form.addRow(self.cb_my_feature)

# 3. Add to save
"my_feature_enabled": bool(self.cb_my_feature.isChecked()),

# 4. Use in features
if cfg.get("my_feature_enabled"):
    # Do something
```

### Pattern 2: Adding a File Picker

```python
# In UI dialog __init__:
self.le_my_file = QLineEdit()
btn_browse = QPushButton("Browse…")

def _on_browse():
    file, _ = QFileDialog.getOpenFileName(
        self, "Select file", "", "Files (*)"
    )
    if file:
        self.le_my_file.setText(file)

qconnect(btn_browse.clicked, _on_browse)

audio_row = QWidget()
audio_layout = QHBoxLayout(audio_row)
audio_layout.addWidget(self.le_my_file, 1)
audio_layout.addWidget(btn_browse)
form.addRow("My File", audio_row)

# In _on_ok():
"my_file_path": str(self.le_my_file.text()).strip(),
```

### Pattern 3: Adding HTML to Cards

```python
def _build_my_element(cfg: dict) -> str:
    """Generate custom HTML for my feature."""
    if not cfg.get("my_feature_enabled"):
        return ""
    
    my_content = "<div>My feature content</div>"
    js_code = """
    <script>
    (function() {
        console.log('My feature loaded');
    })();
    </script>
    """
    return my_content + js_code
```

### Pattern 4: Persistent DOM Elements (Like Website)

```python
# In features.py - use global flag for first-time setup
_my_element_created: bool = False

def _create_persistent_element() -> str:
    global _my_element_created
    
    if not _my_element_created:
        # First time: create element and store in JavaScript
        html = """
        <div id="my-persistent-element">Content</div>
        <script>
        if (window._myPersistentElement) {
            window._myPersistentElement = document.getElementById('my-persistent-element');
        }
        </script>
        """
        _my_element_created = True
    else:
        # Subsequent times: restore from storage
        html = """
        <div id="placeholder"></div>
        <script>
        if (window._myPersistentElement) {
            document.getElementById('placeholder').replaceWith(window._myPersistentElement);
        }
        </script>
        """
    return html
```

## Debugging Tips

### Enable Python Logging
```python
import logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)
logger.debug("Debug message")
```

### Print to Anki Console
```python
print("[StudyCompanion] Debug: my variable =", my_var)
```

### JavaScript Debugging
Open browser console in Anki web view:
```javascript
console.log("Debug:", something);
// Access Anki API
pycmd('myCommand:data');
```

### Check Configuration
```python
from config_manager import get_config
cfg = get_config()
print("[StudyCompanion] Config:", cfg)
```

## Performance Tips

1. **Cache expensive operations**: Use module-level globals like `_quotes_cache`
2. **Minimize DOM manipulation**: Build complete HTML string, inject once
3. **Defer non-critical operations**: Use late initialization
4. **Reuse objects**: Don't create new players/dialogs each time

## Security Considerations

1. **HTML Escaping**: Always use `html.escape()` for user content
2. **URL Validation**: Check URLs before embedding in iframes
3. **File Path Validation**: Use `sanitize_folder_name()` for user paths
4. **JavaScript Injection**: Validate all data before embedding in JS

## Example: Complete New Feature

### Adding a "Timer" Feature

```python
# timer_manager.py
"""Study timer for StudyCompanion."""

_timer_start_time: int | None = None

def get_session_duration() -> int:
    """Get seconds studying in current session."""
    global _timer_start_time
    if _timer_start_time is None:
        return 0
    import time
    return int(time.time() - _timer_start_time)

def start_session() -> None:
    global _timer_start_time
    import time
    _timer_start_time = time.time()
```

```python
# In features.py
from .timer_manager import get_session_duration

def _build_timer_display(cfg: dict) -> str:
    if not cfg.get("show_timer"):
        return ""
    
    duration = get_session_duration()
    minutes = duration // 60
    seconds = duration % 60
    
    return f"""
    <div style="font-size: 0.8em; color: #888; text-align: right;">
        Study time: {minutes}:{seconds:02d}
    </div>
    """
```

```python
# In __init__.py
from .timer_manager import start_session

def _on_main_window_init():
    start_session()
    # ... rest
```

## Next Steps

1. Read [ARCHITECTURE.md](ARCHITECTURE.md) for detailed module documentation
2. Review existing modules to understand patterns
3. Create a feature branch for your changes
4. Test thoroughly before merging
5. Update documentation with your changes
