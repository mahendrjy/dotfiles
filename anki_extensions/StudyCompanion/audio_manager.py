"""
Audio management for StudyCompanion add-on.
Handles background audio playback, looping, and volume control.
"""

import os
from PyQt6.QtMultimedia import QMediaPlayer, QAudioOutput
from PyQt6.QtCore import QUrl as QtCoreQUrl


_audio_player: QMediaPlayer | None = None
_audio_output: QAudioOutput | None = None


def setup_audio_player(cfg: dict) -> None:
    """Setup audio player with looping and volume control."""
    global _audio_player, _audio_output
    try:
        audio_file = str(cfg.get("audio_file_path", "")).strip()
        audio_volume = int(cfg.get("audio_volume", 50) or 50)

        # Create player and audio output if not exists
        if _audio_player is None:
            _audio_player = QMediaPlayer()
            _audio_output = QAudioOutput()
            _audio_player.setAudioOutput(_audio_output)
            # Connect to end of media to loop
            try:
                from PyQt6.QtMultimedia import QMediaPlayer as _QMP
                def _on_status_change(status):
                    if status == _QMP.MediaStatus.EndOfMedia and _audio_player:
                        _audio_player.setPosition(0)
                        _audio_player.play()
                _audio_player.mediaStatusChanged.connect(_on_status_change)
            except Exception:
                pass

        if audio_file and os.path.exists(audio_file):
            _audio_player.setSource(QtCoreQUrl.fromLocalFile(audio_file))
            _audio_output.setVolume(max(0.0, min(1.0, audio_volume / 100.0)))
            _audio_player.play()
        else:
            if _audio_player:
                try:
                    _audio_player.stop()
                except Exception:
                    pass
    except Exception as e:
        print(f"[StudyCompanion] Error setting up audio player: {e}")


def stop_audio() -> None:
    """Stop the audio player."""
    global _audio_player
    try:
        if _audio_player:
            _audio_player.stop()
    except Exception as e:
        print(f"[StudyCompanion] Error stopping audio: {e}")
