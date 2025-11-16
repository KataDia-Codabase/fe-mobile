import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';

abstract class AudioWaveformController {
  Stream<Duration> get positionStream;
  Duration? get duration;
  Stream<double?> get amplitudeStream;
}

class AudioWaveform extends StatefulWidget {
  final AudioWaveformController? controller;
  final double height;
  final Color? color;
  final Color? activeColor;
  final int? maxBars;
  final bool showProgress;

  const AudioWaveform({
    super.key,
    this.controller,
    this.height = 60.0,
    this.color,
    this.activeColor,
    this.maxBars,
    this.showProgress = true,
  });

  @override
  State<AudioWaveform> createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<AudioWaveform>
    with TickerProviderStateMixin {
  static const List<double> _mockWaveformData = [
    0.2, 0.4, 0.6, 0.8, 1.0, 0.9, 0.7, 0.5, 0.3, 0.2,
    0.4, 0.6, 0.8, 0.6, 0.4, 0.2, 0.3, 0.5, 0.7, 0.6,
    0.8, 0.9, 0.7, 0.5, 0.3, 0.4, 0.6, 0.8, 0.9, 0.7,
  ];

  late AnimationController _wavesController;
  List<double> _waveData = _mockWaveformData;
  Duration _currentPosition = Duration.zero;
  Duration? _totalDuration;

  @override
  void initState() {
    super.initState();
    _wavesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    // Initialize with mock data
    _generateMockWaveData();
    
    if (widget.controller != null) {
      _listenToAudioController();
    }
  }

  void _generateMockWaveData() {
    final random = math.Random();
    final barCount = widget.maxBars ?? 60;
    _waveData = List.generate(
      barCount,
      (index) => 0.2 + (random.nextDouble() * 0.8),
    );
  }

  void _listenToAudioController() {
    if (widget.controller == null) return;

    // Listen to position updates
    widget.controller!.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    // Listen to amplitude data
    widget.controller!.amplitudeStream.listen((amplitude) {
      if (amplitude != null && mounted) {
        _updateWaveData(amplitude);
      }
    });
  }

  void _updateWaveData(double amplitude) {
    setState(() {
      // Add new amplitude value to wave data
      _waveData.add(amplitude);
      if (_waveData.length > (widget.maxBars ?? 60)) {
        _waveData.removeAt(0);
      }
    });
  }

  @override
  void dispose() {
    _wavesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.color ?? AppColors.primary.withOpacity(0.3);
    final activeColor = widget.activeColor ?? AppColors.primary;
    
    return AnimatedBuilder(
      animation: _wavesController,
      builder: (context, child) {
        return CustomPaint(
          size: Size(double.infinity, widget.height),
          painter: WaveformPainter(
            waveData: _waveData,
            defaultColor: defaultColor,
            activeColor: activeColor,
            currentPosition: _currentPosition,
            totalDuration: _totalDuration,
            animationValue: _wavesController.value,
            showProgress: widget.showProgress,
          ),
        );
      },
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<double> waveData;
  final Color defaultColor;
  final Color activeColor;
  final Duration currentPosition;
  final Duration? totalDuration;
  final double animationValue;
  final bool showProgress;

  WaveformPainter({
    required this.waveData,
    required this.defaultColor,
    required this.activeColor,
    required this.currentPosition,
    this.totalDuration,
    required this.animationValue,
    required this.showProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (waveData.isEmpty) return;

    final barWidth = size.width / waveData.length;
    final barWidthActual = barWidth * 0.6;
    
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    
    final progressRatio = showProgress && totalDuration != null
        ? currentPosition.inMilliseconds / totalDuration!.inMilliseconds
        : 0.0;
    
    final activeBarCount = (waveData.length * progressRatio).round();

    for (int i = 0; i < waveData.length; i++) {
      final amplitude = waveData[i];
      final animatedAmplitude = amplitude * (0.8 + (0.2 * math.sin(animationValue * 2 * math.pi + i * 0.3)));
      final barHeight = size.height * 0.8 * animatedAmplitude;
      final x = (i * barWidth) + (barWidth / 2);
      final y = (size.height / 2) - (barHeight / 2);
      
      // Set color based on progress
      if (i <= activeBarCount) {
        paint.color = activeColor.withOpacity(0.8 + (0.2 * animatedAmplitude));
      } else {
        paint.color = defaultColor;
      }
      
      // Draw the waveform bar
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidthActual, barHeight),
          Radius.circular(barWidthActual / 2),
        ),
        paint,
      );
    }
    
    // Draw progress indicator
    if (showProgress && totalDuration != null) {
      final progressX = size.width * progressRatio;
      
      canvas.drawLine(
        Offset(progressX, 0),
        Offset(progressX, size.height),
        Paint()
          ..color = activeColor
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) {
    return oldDelegate.waveData != waveData ||
           oldDelegate.currentPosition != currentPosition ||
           oldDelegate.animationValue != animationValue ||
           oldDelegate.totalDuration != totalDuration;
  }
}
