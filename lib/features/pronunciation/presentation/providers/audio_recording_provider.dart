import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';
import 'dart:io';

enum AudioRecordingState {
  idle,
  askingPermission,
  preparing,
  recording,
  paused,
  stopped,
  processing,
  completed,
  error,
}

class AudioRecordingStateNotifier extends StateNotifier<AudioRecordingState> {
  AudioRecordingStateNotifier() : super(AudioRecordingState.idle);

  late FlutterSoundRecorder _recorder;
  String? _recordingPath;
  Duration _recordingDuration = Duration.zero;
  Stream<Duration>? _durationStream;
  final Logger _logger = Logger();

  AudioRecordingState get currentState => state;
  bool get isRecording => state == AudioRecordingState.recording;
  bool get isPaused => state == AudioRecordingState.paused;
  bool get isProcessing => [
        AudioRecordingState.processing,
        AudioRecordingState.completed,
      ].contains(state);
  String? get recordingPath => _recordingPath;
  Duration get recordingDuration => _recordingDuration;

  Future<void> initialize() async {
    try {
      state = AudioRecordingState.preparing;
      _recorder = FlutterSoundRecorder();
      await _recorder.openRecorder();
      state = AudioRecordingState.idle;
      _logger.i('Audio recorder initialized successfully');
    } catch (e) {
      _logger.e('Failed to initialize audio recorder: $e');
      state = AudioRecordingState.error;
    }
  }

  Future<bool> requestMicrophonePermission() async {
    try {
      state = AudioRecordingState.askingPermission;
      final status = await Permission.microphone.request();
      
      if (status == PermissionStatus.granted) {
        state = AudioRecordingState.idle;
        return true;
      } else if (status == PermissionStatus.permanentlyDenied) {
        // User has permanently denied permission
        await openAppSettings();
        return false;
      }
      
      state = AudioRecordingState.idle;
      return false;
    } catch (e) {
      _logger.e('Error requesting microphone permission: $e');
      state = AudioRecordingState.error;
      return false;
    }
  }

  Future<void> startRecording() async {
    try {
      // Check permission first
      final hasPermission = await requestMicrophonePermission();
      if (!hasPermission) {
        _logger.w('Microphone permission denied');
        return;
      }

      state = AudioRecordingState.preparing;
      
      // Initialize recorder if not already done
      try {
        await initialize();
      } catch (e) {
        _logger.e('Recorder initialization failed: $e');
      }

      // Create temporary file path
      final tempDir = await getTemporaryDirectory();
      _recordingPath = '${tempDir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.wav';

      // Start recording
      await _recorder.startRecorder(
        toFile: _recordingPath,
        codec: Codec.pcm16WAV,
      );

      // Start duration tracking
      _startDurationTracking();

      state = AudioRecordingState.recording;
      _logger.i('Recording started: $_recordingPath');

    } catch (e) {
      _logger.e('Error starting recording: $e');
      state = AudioRecordingState.error;
    }
  }

  Future<void> pauseRecording() async {
    try {
      if (state == AudioRecordingState.recording) {
        await _recorder.pauseRecorder();
        state = AudioRecordingState.paused;
        _logger.i('Recording paused');
      }
    } catch (e) {
      _logger.e('Error pausing recording: $e');
      state = AudioRecordingState.error;
    }
  }

  Future<void> resumeRecording() async {
    try {
      if (state == AudioRecordingState.paused) {
        await _recorder.resumeRecorder();
        state = AudioRecordingState.recording;
        _logger.i('Recording resumed');
      }
    } catch (e) {
      _logger.e('Error resuming recording: $e');
      state = AudioRecordingState.error;
    }
  }

  Future<String?> stopRecording() async {
    try {
      if ([AudioRecordingState.recording, AudioRecordingState.paused].contains(state)) {
        state = AudioRecordingState.processing;
        
        // Stop duration tracking
        _stopDurationTracking();

        // Stop recording
        final path = await _recorder.stopRecorder();
        
        state = AudioRecordingState.completed;
        _logger.i('Recording stopped and saved to: $path');
        
        return _recordingPath;
      }
      return null;
    } catch (e) {
      _logger.e('Error stopping recording: $e');
      state = AudioRecordingState.error;
      return null;
    }
  }

  Future<void> cancelRecording() async {
    try {
      if ([AudioRecordingState.recording, AudioRecordingState.paused].contains(state)) {
        await _recorder.stopRecorder();
        
        // Delete temporary file if it exists
        if (_recordingPath != null) {
          final file = (_recordingPath != null) ? 
            await getFile(_recordingPath!) : null;
          if (file != null && await file.exists()) {
            await file.delete();
          }
        }
        
        _recordingPath = null;
        _recordingDuration = Duration.zero;
        _stopDurationTracking();
        
        state = AudioRecordingState.stopped;
        _logger.i('Recording cancelled and file deleted');
      }
    } catch (e) {
      _logger.e('Error cancelling recording: $e');
      state = AudioRecordingState.error;
    }
  }

  void reset() {
    _recordingPath = null;
    _recordingDuration = Duration.zero;
    _stopDurationTracking();
    state = AudioRecordingState.idle;
  }

  Stream<Duration> getDurationStream() {
    return _recorder.onProgress?.map((progress) {
      final durationMs = progress.duration as int? ?? 0;
      return Duration(milliseconds: durationMs);
    }) ?? Stream.value(Duration.zero);
  }

  void _startDurationTracking() {
    _durationStream = getDurationStream();
    _durationStream?.listen((duration) {
      _recordingDuration = duration;
    });
  }

  void _stopDurationTracking() {
    _durationStream = null;
  }

  @override
  void dispose() {
    _disposeRecorder();
    super.dispose();
  }

  Future<void> _disposeRecorder() async {
    try {
      await _recorder.closeRecorder();
      _logger.i('Audio recorder disposed');
    } catch (e) {
      _logger.e('Error disposing recorder: $e');
    }
  }
}

// Provider
final audioRecordingProvider = StateNotifierProvider<AudioRecordingStateNotifier, AudioRecordingState>(
  (ref) => AudioRecordingStateNotifier(),
);

// Helper function to get file
Future<File?> getFile(String path) async {
  try {
    return File(path);
  } catch (e) {
    Logger().e('Error getting file: $e');
    return null;
  }
}
