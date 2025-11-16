import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

import 'notification_types.dart';
import 'notification_channels.dart';
import 'notification_preferences.dart' as prefs;

/// Comprehensive notification service for BahasaKu AI
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final Logger _logger = Logger();
  bool _initialized = false;

  /// Initialize notification service
  Future<bool> initialize() async {
    try {
      // Initialize timezone
      tz.initializeTimeZones();
      
      // Request permissions
      final hasPermission = await _requestPermissions();
      if (!hasPermission) {
        _logger.w('Notification permissions denied');
        return false;
      }

      // Initialize Android settings
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // Initialize iOS settings
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      // Initialize the plugin
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationTap,
      );

      // Create notification channels
      await _createNotificationChannels();
      
      // Setup notification handlers
      _setupNotificationHandlers();

      _initialized = true;
      _logger.i('Notification service initialized successfully');
      return true;
    } catch (e) {
      _logger.e('Failed to initialize notification service: $e');
      return false;
    }
  }

  /// Request notification permissions
  Future<bool> _requestPermissions() async {
    if (Platform.isIOS) {
      final bool? result = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return result ?? false;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      
      // Also request exact alarms for scheduled notifications
      final bool? grantedExactAlarmPermission =
          await androidImplementation?.requestExactAlarmsPermission();

      return (grantedNotificationPermission ?? false) && 
             (grantedExactAlarmPermission ?? false);
    }
    
    // For web and other platforms
    return await Permission.notification.request().isGranted;
  }

  /// Create all notification channels
  Future<void> _createNotificationChannels() async {
    if (!Platform.isAndroid) return;

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    // Create each channel properly using the channel creation methods
    await androidImplementation?.createNotificationChannel(
      NotificationChannels.createGeneralChannel(),
    );
    await androidImplementation?.createNotificationChannel(
      NotificationChannels.createStreakChannel(),
    );
    await androidImplementation?.createNotificationChannel(
      NotificationChannels.createAchievementsChannel(),
    );
    await androidImplementation?.createNotificationChannel(
      NotificationChannels.createLessonsChannel(),
    );
    await androidImplementation?.createNotificationChannel(
      NotificationChannels.createSystemChannel(),
    );
  }

  /// Setup notification tap handlers
  void _setupNotificationHandlers() {
    // Handle background notifications (if needed with workmanager)
  }

  /// Handle notification tap
  void _onNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    _logger.i('Notification tapped: ${response.id}, payload: $payload');
    
    // Handle different notification types based on payload
    if (payload != null) {
      _handleNotificationTapByPayload(payload);
    }
  }

  /// Handle notification tap based on payload
  void _handleNotificationTapByPayload(String payload) {
    try {
      // Parse payload format: "type:id:data"
      final parts = payload.split(':');
      if (parts.isEmpty) return;

      final notificationType = parts[0];
      final data = parts.length > 1 ? parts.sublist(1).join(':') : null;

      switch (notificationType) {
        case NotificationType.streakReminder:
          _handleStreakReminderTap(data);
          break;
        case NotificationType.achievement:
          _handleAchievementTap(data);
          break;
        case NotificationType.lessonReminder:
          _handleLessonReminderTap(data);
          break;
        case NotificationType.streakWarning:
          _handleStreakWarningTap(data);
          break;
        default:
          _logger.w('Unknown notification type: $notificationType');
      }
    } catch (e) {
      _logger.e('Error handling notification tap: $e');
    }
  }

  /// Show immediate notification
  Future<void> showNotification({
    required String title,
    required String body,
    required String notificationType,
    String? payload,
    String channelId = NotificationChannels.general,
  }) async {
    if (!_isNotificationsEnabled()) return;

    final details = await _getNotificationDetails(channelId);
    
    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
      payload: payload ?? '$notificationType:$title',
    );
  }

  /// Schedule notification with time
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    required String notificationType,
    String? payload,
    String channelId = NotificationChannels.general,
  }) async {
    if (!_isNotificationsEnabled()) return;

    final details = await _getNotificationDetails(channelId);
    
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload ?? '$notificationType:$title',
    );
  }

  /// Schedule recurring notification
  Future<void> scheduleRecurringNotification({
    required String title,
    required String body,
    required RecurrenceType recurrence,
    required Time time,
    required String notificationType,
    String? payload,
    String channelId = NotificationChannels.general,
  }) async {
    if (!_isNotificationsEnabled()) return;

    final details = await _getNotificationDetails(channelId);
    
    // Calculate next occurrence
    DateTime nextOccurrence = _calculateNextOccurrence(recurrence, time);
    
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      tz.TZDateTime.from(nextOccurrence, tz.local),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload ?? '$notificationType:$title',
      matchDateTimeComponents: _getDateTimeComponents(recurrence),
    );
  }

  /// Cancel notification by ID
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  /// Get notification details
  Future<NotificationDetails> _getNotificationDetails(String channelId) async {
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channelId,
      _getChannelName(channelId),
      channelDescription: _getChannelDescription(channelId),
      importance: _getChannelImportance(channelId),
      priority: _getChannelPriority(channelId),
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      color: _getChannelColor(channelId),
      enableVibration: true,
      playSound: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  /// Check if notifications are enabled
  bool _isNotificationsEnabled() {
    return _initialized && prefs.NotificationPreferences.isNotificationsEnabled();
  }

  /// Calculate next occurrence for recurring notifications
  DateTime _calculateNextOccurrence(RecurrenceType recurrence, Time time) {
    final now = DateTime.now();
    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    switch (recurrence) {
      case RecurrenceType.once:
        if (scheduled.isBefore(now)) {
          scheduled = scheduled.add(const Duration(days: 1));
        }
        break;
      case RecurrenceType.daily:
        if (scheduled.isBefore(now)) {
          scheduled = scheduled.add(const Duration(days: 1));
        }
        break;
      case RecurrenceType.weekly:
        if (scheduled.isBefore(now)) {
          scheduled = scheduled.add(const Duration(days: 7));
        }
        break;
      case RecurrenceType.monthly:
        if (scheduled.isBefore(now)) {
          scheduled = DateTime(
            now.year,
            now.month + 1,
            scheduled.day,
            time.hour,
            time.minute,
          );
        }
        break;
    }

    return scheduled;
  }

  /// Get date time components for recurrence
  DateTimeComponents? _getDateTimeComponents(RecurrenceType recurrence) {
    return switch (recurrence) {
      RecurrenceType.once => null, // No recurrence
      RecurrenceType.daily => DateTimeComponents.time,
      RecurrenceType.weekly => DateTimeComponents.dayOfWeekAndTime,
      RecurrenceType.monthly => DateTimeComponents.dayOfMonthAndTime,
    };
  }

  /// Get channel name
  String _getChannelName(String channelId) {
    switch (channelId) {
      case NotificationChannels.streak:
        return 'Learning Streak';
      case NotificationChannels.achievements:
        return 'Achievements';
      case NotificationChannels.lessons:
        return 'Lesson Reminders';
      case NotificationChannels.system:
        return 'System Notifications';
      default:
        return 'General Notifications';
    }
  }

  /// Get channel description
  String _getChannelDescription(String channelId) {
    switch (channelId) {
      case NotificationChannels.streak:
        return 'Notifications about your learning streak and daily goals';
      case NotificationChannels.achievements:
        return 'Notifications for unlocked achievements and milestones';
      case NotificationChannels.lessons:
        return 'Reminders for scheduled lessons and practice sessions';
      case NotificationChannels.system:
        return 'Important system updates and maintenance notifications';
      default:
        return 'General app notifications';
    }
  }

  /// Get channel importance
  Importance _getChannelImportance(String channelId) {
    switch (channelId) {
      case NotificationChannels.streak:
      case NotificationChannels.system:
        return Importance.high;
      case NotificationChannels.achievements:
        return Importance.defaultImportance;
      case NotificationChannels.lessons:
        return Importance.max;
      default:
        return Importance.defaultImportance;
    }
  }

  /// Get channel priority
  Priority _getChannelPriority(String channelId) {
    switch (channelId) {
      case NotificationChannels.system:
        return Priority.high;
      case NotificationChannels.lessons:
        return Priority.max;
      default:
        return Priority.defaultPriority;
    }
  }

  /// Get channel color
  Color _getChannelColor(String channelId) {
    switch (channelId) {
      case NotificationChannels.streak:
        return Colors.orange;
      case NotificationChannels.achievements:
        return Colors.purple;
      case NotificationChannels.lessons:
        return Colors.blue;
      case NotificationChannels.system:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  /// Handle streak reminder tap
  void _handleStreakReminderTap(String? data) {
    // Navigate to practice screen or streak status
    _logger.i('Streak reminder tapped');
  }

  /// Handle achievement notification tap
  void _handleAchievementTap(String? data) {
    // Navigate to achievements screen
    _logger.i('Achievement notification tapped');
  }

  /// Handle lesson reminder tap
  void _handleLessonReminderTap(String? data) {
    // Navigate to specific lesson
    _logger.i('Lesson reminder tapped');
  }

  /// Handle streak warning tap
  void _handleStreakWarningTap(String? data) {
    // Navigate to practice or streak management
    _logger.i('Streak warning tapped');
  }

  /// Dispose service
  Future<void> dispose() async {
    // FlutterLocalNotificationsPlugin doesn't have a dispose method
    // Just reset the initialization state
    _initialized = false;
  }

  /// Get service initialization status
  bool get isInitialized => _initialized;
}
