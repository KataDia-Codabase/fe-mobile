import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Performance monitoring and metrics for production
class ProductionMonitoring {
  static final Logger _logger = Logger();
  
  /// Production performance metrics
  Map<String, double> get currentMetrics {
    return {
      'memory_usage_mb': _currentMemoryUsage,
      'cpu_usage_percent': _currentCpuUsage,
      'fps': _currentFPS,
      'network_latency_ms': _networkLatency,
    };
  }

  /// Check if performance targets are being met
  Map<String, bool> get performanceCompliance {
    final metrics = currentMetrics;
    final compliance = <String, bool>{};
    
    // Memory compliance (<150MB)
    compliance['memory'] = metrics['memory_usage_mb']! < 150.0;
    
    // CPU usage (<70%)
    compliance['cpu'] = metrics['cpu_usage_percent']! < 70.0;
    
    // FPS performance (>30fps)
    compliance['fps'] = metrics['fps']! >= 30.0;
    
    // Network latency (<500ms)
    compliance['network'] = metrics['network_latency_ms']! < 500.0;
    
    compliance['overall'] = metrics.values.every((metric) => _passesTarget(metric, 'cpu', 'memory', 'fps', 'network'));
    
    return compliance;
  }

  /// Generate production report
  Future<Map<String, dynamic>> generateProductionReport() async {
    try {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      final packageInfo = await PackageInfo.fromPlatform();
      
      return {
        'app_info': {
          'version': packageInfo.version,
          'build_number': packageInfo.buildNumber,
          'package_name': packageInfo.packageName,
          'app_name': 'KataDia',
        },
        'device_info': {
          'manufacturer': deviceInfo.manufacturer,
          'model': deviceInfo.model,
          'system_version': deviceInfo.version.release,
          'brand': deviceInfo.brand,
        },
        'performance_metrics': currentMetrics,
        'performance_compliance': performanceCompliance,
        'timestamp': DateTime.now().toIso8601String(),
        'uptime_ms': DateTime.now().difference(_appStartTime).inMilliseconds,
        'user_agent': _buildUserAgent(),
      };
    } catch (e) {
      _logger.e('Failed to generate production report: $e');
      return {
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }

  /// Monitor and log performance issues
  void monitorPerformance() {
    final compliance = performanceCompliance;
    
    if (!(compliance['overall'] ?? true)) {
      final issues = compliance.entries
          .where((entry) => !entry.value)
          .map((entry) => '${entry.key}: ${entry.value ? 'PASS' : 'FAIL'}')
          .toList();
      
      if (issues.isNotEmpty) {
        _logger.w('Performance compliance issues detected: $issues');
      }
    }
    
    // Log performance metrics
    final metrics = currentMetrics;
    _logger.d('Performance metrics: $metrics');
  }

  /// Track specific operation performance
  Future<T> trackOperation<T>(
    String operationName,
    Future<T> Function() operation, {
    Map<String, dynamic>? metadata,
  }) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      _logger.d('Starting operation: $operationName');
      
      final result = await operation();
      
      stopwatch.stop();
      
      final duration = stopwatch.elapsedMilliseconds;
      
      _logOperationMetrics(operationName, duration, success: true);
      
      if (metadata != null) {
        _logger.d('Operation metadata for $operationName: $metadata');
      }
      
      return result;
    } catch (e) {
      stopwatch.stop();
      
      final duration = stopwatch.elapsedMilliseconds;
      
      _logOperationMetrics(operationName, duration, success: false);
      _logger.e('Operation failed: $operationName', error: e);
      
      rethrow;
    }
  }

  /// Get performance recommendations
  List<String> getPerformanceRecommendations() {
    final recommendations = <String>[];
    final metrics = currentMetrics;
    
    if (metrics['memory_usage_mb']! > 120) {
      recommendations.add('Memory usage is high. Consider optimizing image caching.');
    }
    
    if (metrics['cpu_usage_percent']! > 60) {
      recommendations.add('High CPU usage detected. Consider reducing background tasks.');
    }
    
    if (metrics['fps']! < 30) {
      recommendations.add('Frame rate is low. Consider reducing animation complexity.');
    }
    
    if (metrics['network_latency_ms']! > 400) {
      recommendations.add('Network latency is high. Caching should be increased.');
    }
    
    return recommendations;
  }

  // Private helper methods
  
  static DateTime get _appStartTime {
    return DateTime.now().subtract(Duration(seconds: 10));
  }
  
  static double get _currentMemoryUsage {
    // Simulate memory usage calculation
    return 125.5 + (DateTime.now().millisecond % 50);
  }
  
  static double get _currentCpuUsage {
    // Simulate CPU usage
    return 25.3 + (DateTime.now().millisecond % 60);
  }
  
  static double get _currentFPS {
    // Simulate FPS measurement
    return 58.0 + (DateTime.now().millisecond % 30) / 10.0;
  }
  
  static double get _networkLatency {
    // Simulate network latency
    return 320.0 + (DateTime.now().millisecond % 200);
  }
  
  static String _buildUserAgent() {
    return 'KataDia/1.0.0 (Android; BuildModel)';
  }
  
  void _logOperationMetrics(String operation, int durationMs, {bool success = true}) {
    _logger.i('Operation: $operation | Duration: ${durationMs}ms | Success: $success');
  }

  bool _passesTarget(dynamic metric, String cpu, String memory, String fps, String network) {
    switch (cpu) {
      case 'cpu':
        return (metric as num) < 70.0;
      case 'memory':
        return (metric as num) < 150.0;
      case 'fps':
        return (metric as num) >= 30.0;
      case 'network':
        return (metric as num) < 500.0;
      default:
        return true;
    }
  }
}

/// Performance monitoring provider
final productionMonitoringProvider = Provider<ProductionMonitoring>((ref) {
  return ProductionMonitoring();
});

/// Performance-aware widget for monitoring
class PerformanceAwareWidget extends StatelessWidget {
  const PerformanceAwareWidget({
    super.key,
    required this.child,
    this.performanceKey,
  });
  
  final Widget child;
  final String? performanceKey;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext builderContext) {
        // Monitor performance when widget is built
        // final monitoring = builderContext.read(productionMonitoringProvider);
        // monitoring.monitorPerformance();
        
        return child;
      },
    );
  }
}

/// Performance tracker for specific operations
class PerformanceTracker {
  final String _operationName;
  final Stopwatch _stopwatch;
  
  PerformanceTracker(this._operationName) : _stopwatch = Stopwatch();
  
  /// Start tracking operation
  void start() {
    _stopwatch.start();
  }
  
  /// Stop tracking and log
  void stop() {
    _stopwatch.stop();
    final duration = _stopwatch.elapsedMilliseconds;
    
    Logger().d('Performance: $_operationName | Duration: ${duration}ms');
  }
  
  /// Execute operation with performance tracking
  Future<T> track<T>(Future<T> Function() operation, {String? key}) async {
    _stopwatch.start();
    try {
      final result = await operation();
      _stopwatch.stop();
      return result;
    } catch (e) {
      _stopwatch.stop();
      rethrow;
    }
  }
}
