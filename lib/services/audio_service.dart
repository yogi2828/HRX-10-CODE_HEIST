// lib/services/audio_service.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:gamifier/constants/app_constants.dart';

class AudioService {
  late AudioPlayer _correctPlayer;
  late AudioPlayer _levelUpPlayer;

  AudioService() {
    _correctPlayer = AudioPlayer();
    _levelUpPlayer = AudioPlayer();
  }

  Future<void> loadAudioAssets() async {
    try {
      await _correctPlayer.setSourceAsset(AppConstants.correctSoundPath);
      await _levelUpPlayer.setSourceAsset(AppConstants.levelUpSoundPath);
      debugPrint('Audio assets loaded successfully.');
    } catch (e) {
      debugPrint('Error loading audio assets: $e');
    }
  }

  Future<void> playCorrectSound() async {
    try {
      await _correctPlayer.stop();
      await _correctPlayer.resume();
      await _correctPlayer.play(AssetSource(AppConstants.correctSoundPath));
    } catch (e) {
      debugPrint('Error playing correct sound: $e');
    }
  }

  Future<void> playLevelUpSound() async {
    try {
      await _levelUpPlayer.stop();
      await _levelUpPlayer.resume();
      await _levelUpPlayer.play(AssetSource(AppConstants.levelUpSoundPath));
    } catch (e) {
      debugPrint('Error playing level up sound: $e');
    }
  }

  void dispose() {
    _correctPlayer.dispose();
    _levelUpPlayer.dispose();
  }
}