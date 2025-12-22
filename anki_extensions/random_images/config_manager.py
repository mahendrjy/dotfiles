"""
Configuration management for StudyCompanion add-on.
Handles config loading, validation, and persistence.
"""

import os
import json
from aqt import mw


def get_defaults() -> dict:
    """Return default configuration values."""
    return {
        "enabled": True,
        "show_on_question": True,
        "show_on_answer": True,
        "folder_name": "study_companion_images",
        "max_width_percent": 80,
        "max_height_vh": 60,
        "avoid_repeat": True,
        "show_motivation_quotes": True,
        "images_to_show": 1,
        # Website embed (optional)
        "website_url": "",
        "website_height_vh": 80,
        "website_display_mode": "mobile",  # "desktop" or "mobile"
        "website_width_percent": 100,  # width for mobile mode
        # Background audio (optional)
        "audio_file_path": "",
        "audio_volume": 50,
    }


def get_config() -> dict:
    """Load config.json; fall back to defaults on failure."""
    default = get_defaults()
    try:
        cfg = mw.addonManager.getConfig(__name__.split(".")[0])
        if not isinstance(cfg, dict):
            return default
        # Backwards-compat: map old keys if present
        if "show_motivation_quotes" not in cfg and "show_filename" in cfg:
            try:
                cfg["show_motivation_quotes"] = bool(cfg.get("show_filename"))
            except Exception:
                cfg["show_motivation_quotes"] = True
        return {**default, **cfg}
    except Exception as e:
        print(f"[StudyCompanion] Failed to load config: {e}")
        return default


def write_config(new_cfg: dict) -> None:
    """Save config while keeping unknown keys untouched."""
    try:
        addon_name = __name__.split(".")[0]
        old = mw.addonManager.getConfig(addon_name)
        if not isinstance(old, dict):
            old = {}
        merged = {**old, **new_cfg}
        mw.addonManager.writeConfig(addon_name, merged)
    except Exception as e:
        print(f"[StudyCompanion] Failed to write config: {e}")
