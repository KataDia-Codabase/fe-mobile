import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enums for audio playback
enum AudioPlaybackState {
  playing,
  paused,
  loading,
  stopped,
  completed,
}

enum LoopMode {
  off,
  one,
  all,
}

// Simple audio controller class for demonstration
class AudioPlayerController {
  bool _isInitialized = false;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration? _duration;
  double _speed = 1.0;
  LoopMode _loopMode = LoopMode.off;
  bool _isShuffled = false;

  final StreamController<AudioPlaybackState> _stateController = 
      StreamController.broadcast();
  final StreamController<Duration> _positionController = 
      StreamController.broadcast();
  final StreamController<double?> _amplitudeController = 
      StreamController.broadcast();
  final StreamController<double> _speedController = 
      StreamController.broadcast();

  Stream<AudioPlaybackState> get playbackStateStream => _stateController.stream;
  Stream<Duration> get positionStream => _positionController.stream;
  Stream<double?> get amplitudeStream => _amplitudeController.stream;
  Stream<double> get speedStream => _speedController.stream;

  AudioPlaybackState get currentState => _isPlaying ? 
      AudioPlaybackState.playing : AudioPlaybackState.stopped;
  Duration get position => _position;
  Duration? get duration => _duration;
  bool get isInitialized => _isInitialized;
  bool get canRewind => _position.inSeconds >= 10;
  bool get canFastForward => _duration != null && 
      (_duration!.inSeconds - _position.inSeconds) >= 10;
  double get speed => _speed;
  LoopMode get loopMode => _loopMode;
  bool get isShuffled => _isShuffled;

  Future<void> initialize() async {
    // Simulate initialization
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _isInitialized = true;
    _stateController.add(AudioPlaybackState.stopped);
  }

  Future<void> setUrl(String url) async {
    // Simulate setting URL and getting duration
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _duration = const Duration(seconds: 30); // Mock 30 second audio
    _position = Duration.zero;
    
    // Start position simulation
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_position >= _duration!) {
        timer.cancel();
        _position = _duration!;
        _stateController.add(AudioPlaybackState.completed);
        _isPlaying = false;
      } else if (_isPlaying) {
        _position = Duration(
          milliseconds: _position.inMilliseconds + 100,
        );
        _positionController.add(_position);
        
        // Simulate amplitude data
        final amplitude = 0.3 + (0.7 * (_position.inMilliseconds % 1000) / 1000);
        _amplitudeController.add(amplitude);
      }
    });
  }

  Future<void> play() async {
    if (!_isInitialized) return;
    
    _isPlaying = true;
    _stateController.add(AudioPlaybackState.playing);
  }

  Future<void> pause() async {
    _isPlaying = false;
    _stateController.add(AudioPlaybackState.paused);
  }

  Future<void> stop() async {
    _isPlaying = false;
    _position = Duration.zero;
    _stateController.add(AudioPlaybackState.stopped);
    _positionController.add(_position);
  }

  Future<void> seek(Duration position) async {
    if (position.inSeconds < 0) {
      _position = Duration.zero;
    } else if (_duration != null && position > _duration!) {
      _position = _duration!;
    } else {
      _position = position;
    }
    _positionController.add(_position);
  }

  Future<void> setSpeed(double speed) async {
    _speed = speed.clamp(0.5, 2.0);
    _speedController.add(_speed);
  }

  Future<void> setLoopMode(LoopMode mode) async {
    _loopMode = mode;
  }

  Future<void> toggleShuffleMode() async {
    _isShuffled = !_isShuffled;
  }

  void dispose() {
    _stateController.close();
    _positionController.close();
    _amplitudeController.close();
    _speedController.close();
  }
}

// Riverpod providers
final audioPlayerControllerProvider = Provider.family<AudioPlayerController, String>(
  (ref, audioUrl) {
    final controller = AudioPlayerController();
    ref.onDispose(() => controller.dispose());
    return controller;
  },
);

final isPlayingProvider = Provider.family<bool, String>(
  (ref, audioUrl) {
    final controller = ref.watch(audioPlayerControllerProvider(audioUrl));
    return controller.currentState == AudioPlaybackState.playing;
  },
);

final audioPositionProvider = Provider.family<Duration, String>(
  (ref, audioUrl) {
    final controller = ref.watch(audioPlayerControllerProvider(audioUrl));
    return controller.position;
  },
);

final audioDurationProvider = Provider.family<Duration?, String>(
  (ref, audioUrl) {
    final controller = ref.watch(audioPlayerControllerProvider(audioUrl));
    return controller.duration;
  },
);
