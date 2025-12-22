# StudyCompanion

A powerful, modular Anki add-on to enhance your study sessions with motivational images, quotes, websites, and ambient audio.

## Features

- 🖼️ **Random Images**: Display random images from your collection during reviews
- 💬 **Motivational Quotes**: 200+ built-in affirmations and study quotes
- 🌐 **Website Embedding**: Optional website display in desktop or mobile grid mode
- 🎵 **Background Audio**: Play ambient music or sounds while studying
- 🎨 **Responsive Design**: Adaptive grid layout (up to 3 images per row)
- ♻️ **Smart Cycling**: Show all images before repeating (avoid_repeat mode)
- ⚙️ **Highly Configurable**: Extensive settings for all features
- 🏗️ **Modular Architecture**: Easily extendable codebase for adding new features

## Installation

1. Open Anki and go to **Tools** → **Add-ons** → **Get Add-ons**
2. Paste the add-on code: `1726486470`
3. Restart Anki

## Configuration

### Via Settings Dialog
1. Go to **Tools** → **StudyCompanion Settings…**
2. Configure your preferences
3. Click **OK** to save

### Configuration Options

#### Core Settings
- **Enable add-on**: Toggle all features on/off
- **Show on Question side**: Display content on question cards
- **Show on Answer side**: Display content on answer cards

#### Image Settings
- **Image folder**: Location inside collection.media (default: `study_companion_images`)
- **Number of images to show**: How many images per card (1-12)
- **Max width**: Maximum width for images (0 = no limit)
- **Max height**: Maximum height for images in viewport height
- **Don't repeat until all shown**: Cycle through all images before repeating

#### Quotes
- **Show motivational quote below image**: Display unique quote under each image
- Custom quotes via `quotes.txt` file

#### Website (Optional)
- **Website URL**: HTTPS URL to embed (optional)
- **Website height**: Height in viewport units
- **Mobile mode**: Display website in grid with images
- **Website width (mobile mode)**: Width percentage for mobile layout

#### Audio (Optional)
- **Background audio**: Path to MP3/WAV/FLAC/AAC/OGG file
- **Audio volume**: 0-100%
- Features: Auto-play, infinite looping

## Quick Start

### 1. Add Images
1. Open your **StudyCompanion** folder: **Tools** → **StudyCompanion Settings…** → **Open folder**
2. Add image files to the folder
3. Restart Anki or open a new card

### 2. Add Custom Quotes
Create a `quotes.txt` file in the add-on folder with one quote per line:

```
Your first inspiring quote
Another motivational message
Keep going, you've got this!
```

### 3. Enable Website Display
1. Open settings
2. Enter a website URL (must be HTTPS)
3. Choose display mode (mobile or desktop)
4. Save and review

### 4. Add Background Audio
1. Open settings
2. Browse for an audio file
3. Set volume level
4. Save and restart Anki

## File Structure

```
StudyCompanion/
├── __init__.py              # Main entry point
├── config_manager.py        # Configuration management
├── image_manager.py         # Image handling
├── quotes.py                # Quote system
├── audio_manager.py         # Audio playback
├── ui_manager.py            # Settings UI
├── features.py              # Core rendering
├── config.json              # User settings
├── quotes.txt               # Custom quotes
├── ARCHITECTURE.md          # Design documentation
└── DEVELOPER_GUIDE.md       # Extension guide
```

## For Developers

### Understanding the Codebase

StudyCompanion is organized into focused modules:

- **config_manager.py**: Configuration loading/saving with defaults
- **image_manager.py**: Image selection, deletion, cycle state
- **quotes.py**: Quote management with built-in library
- **audio_manager.py**: Background audio playback
- **ui_manager.py**: Settings UI components
- **features.py**: Core card rendering logic
- **__init__.py**: Hook registration and initialization

### Extending StudyCompanion

See [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) for:
- How to add new features
- How to extend configuration options
- Architecture patterns
- Testing scenarios

### Architecture Overview

See [ARCHITECTURE.md](ARCHITECTURE.md) for:
- Detailed module documentation
- Extension patterns
- API reference
- Performance considerations

## Troubleshooting

### Images not appearing
- ✓ Check **Image folder** in settings points to existing folder
- ✓ Verify images are in `collection.media/study_companion_images/`
- ✓ Ensure images are PNG, JPG, GIF, WebP, BMP, TIFF, or SVG
- ✓ Restart Anki to reload images

### Website not showing
- ✓ Enter an HTTPS URL (HTTP may be blocked)
- ✓ Ensure the website allows embedding in iframes
- ✓ Check browser console (F12) for CORS errors
- ✓ Try a different website to test

### Audio not playing
- ✓ Verify audio file path is correct
- ✓ Ensure audio format is supported (MP3, WAV, FLAC, AAC, OGG)
- ✓ Check system audio is working
- ✓ Set volume to > 0%

### Quotes not appearing
- ✓ Enable **Show motivational quote below image** in settings
- ✓ If using custom `quotes.txt`, verify file exists and has content
- ✓ Ensure each quote is on its own line

### Performance issues
- ✓ Reduce number of images per card
- ✓ Use smaller image files
- ✓ Disable website embedding if not needed
- ✓ Disable audio if experiencing lag

## Compatibility

- **Anki**: 2.1.45+ (tested on 25.09.2)
- **Python**: 3.10+
- **OS**: Windows, macOS, Linux
- **Other Add-ons**: Compatible (non-invasive hook usage)

## License

[Original license - see LICENSE file]

## Contributing

Contributions welcome! Please see [DEVELOPER_GUIDE.md](DEVELOPER_GUIDE.md) for:
- Code style guidelines
- Testing procedures
- Extension patterns
- Submission guidelines

## Support

For issues or feature requests, please provide:
- Anki version (Help → About)
- Add-on version (check manifest.json)
- Steps to reproduce
- Screenshots/error messages
- Your OS and Python version

## Changelog

### v2.0.0 (Modular Refactor)
- **NEW**: Complete modular architecture for easy extension
- **NEW**: Improved code organization and documentation
- **NEW**: DEVELOPER_GUIDE and ARCHITECTURE documentation
- **IMPROVED**: Backwards compatible with existing configurations
- **IMPROVED**: Better error handling and logging
- All existing features preserved and enhanced

### Previous Features
- Random image display
- Motivational quotes
- Website embedding
- Background audio
- Multi-image grid layout
- Smart image cycling
- Immediate image deletion

## Credits

Built to enhance your study experience and support focused learning.

Happy studying! 📚
