
class NotificationType {
  static const String streakReminder = 'streak_reminder';
  static const String achievement = 'achievement';
  static const String lessonReminder = 'lesson_reminder';
  static const String streakWarning = 'streak_warning';
  static const String progressUpdate = 'progress_update';
  static const String systemUpdate = 'system_update';
}


enum NotificationCategory {
  streak,
  achievements,
  lessons,
  system,
  social,
}


enum RecurrenceType {
  once,
  daily,
  weekly,
  monthly,
}


enum NotificationPriority {
  low,
  normal,
  high,
  critical,
}


class AchievementNotification {
  final String achievementId;
  final String title;
  final String description;
  final String? imageUrl;
  final int xpReward;
  final DateTime unlockedAt;

  const AchievementNotification({
    required this.achievementId,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.xpReward,
    required this.unlockedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'achievementId': achievementId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'xpReward': xpReward,
      'unlockedAt': unlockedAt.toIso8601String(),
    };
  }

  factory AchievementNotification.fromMap(Map<String, dynamic> map) {
    return AchievementNotification(
      achievementId: map['achievementId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String?,
      xpReward: map['xpReward'] as int,
      unlockedAt: DateTime.parse(map['unlockedAt'] as String),
    );
  }
}

/// Streak notification data
class StreakNotification {
  final int currentStreak;
  final int streakGoal;
  final String lastPracticeDate;
  final bool isAtRisk;

  const StreakNotification({
    required this.currentStreak,
    required this.streakGoal,
    required this.lastPracticeDate,
    required this.isAtRisk,
  });

  Map<String, dynamic> toMap() {
    return {
      'currentStreak': currentStreak,
      'streakGoal': streakGoal,
      'lastPracticeDate': lastPracticeDate,
      'isAtRisk': isAtRisk,
    };
  }

  factory StreakNotification.fromMap(Map<String, dynamic> map) {
    return StreakNotification(
      currentStreak: map['currentStreak'] as int,
      streakGoal: map['streakGoal'] as int,
      lastPracticeDate: map['lastPracticeDate'] as String,
      isAtRisk: map['isAtRisk'] as bool,
    );
  }
}

/// Lesson reminder notification data
class LessonReminderNotification {
  final String lessonId;
  final String lessonTitle;
  final String lessonType;
  final DateTime reminderTime;
  final int duration;

  const LessonReminderNotification({
    required this.lessonId,
    required this.lessonTitle,
    required this.lessonType,
    required this.reminderTime,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'lessonTitle': lessonTitle,
      'lessonType': lessonType,
      'reminderTime': reminderTime.toIso8601String(),
      'duration': duration,
    };
  }

  factory LessonReminderNotification.fromMap(Map<String, dynamic> map) {
    return LessonReminderNotification(
      lessonId: map['lessonId'] as String,
      lessonTitle: map['lessonTitle'] as String,
      lessonType: map['lessonType'] as String,
      reminderTime: DateTime.parse(map['reminderTime'] as String),
      duration: map['duration'] as int,
    );
  }
}

/// Progress notification data
class ProgressNotification {
  final String userId;
  final double progressPercentage;
  final int completedLessons;
  final int totalLessons;
  final String currentLevel;
  final double totalXp;

  const ProgressNotification({
    required this.userId,
    required this.progressPercentage,
    required this.completedLessons,
    required this.totalLessons,
    required this.currentLevel,
    required this.totalXp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'progressPercentage': progressPercentage,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'currentLevel': currentLevel,
      'totalXp': totalXp,
    };
  }

  factory ProgressNotification.fromMap(Map<String, dynamic> map) {
    return ProgressNotification(
      userId: map['userId'] as String,
      progressPercentage: map['progressPercentage'] as double,
      completedLessons: map['completedLessons'] as int,
      totalLessons: map['totalLessons'] as int,
      currentLevel: map['currentLevel'] as String,
      totalXp: map['totalXp'] as double,
    );
  }
}

/// System notification data
class SystemNotification {
  final String messageId;
  final String title;
  final String message;
  final String type;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  const SystemNotification({
    required this.messageId,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.metadata,
  });

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'title': title,
      'message': message,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory SystemNotification.fromMap(Map<String, dynamic> map) {
    return SystemNotification(
      messageId: map['messageId'] as String,
      title: map['title'] as String,
      message: map['message'] as String,
      type: map['type'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      metadata: map['metadata'] as Map<String, dynamic>?,
    );
  }
}

/// Notification scheduling configuration
class NotificationSchedule {
  final String id;
  final String type;
  final String title;
  final String body;
  final DateTime scheduledTime;
  final RecurrenceType recurrence;
  final String? payload;
  final String channelId;
  final bool isActive;

  const NotificationSchedule({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.scheduledTime,
    required this.recurrence,
    this.payload,
    required this.channelId,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'body': body,
      'scheduledTime': scheduledTime.toIso8601String(),
      'recurrence': recurrence.name,
      'payload': payload,
      'channelId': channelId,
      'isActive': isActive,
    };
  }

  factory NotificationSchedule.fromMap(Map<String, dynamic> map) {
    return NotificationSchedule(
      id: map['id'] as String,
      type: map['type'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      scheduledTime: DateTime.parse(map['scheduledTime'] as String),
      recurrence: RecurrenceType.values.firstWhere(
        (e) => e.name == map['recurrence'],
        orElse: () => RecurrenceType.once,
      ),
      payload: map['payload'] as String?,
      channelId: map['channelId'] as String,
      isActive: map['isActive'] as bool,
    );
  }
}

/// Notification preferences
class NotificationPreferences {
  final bool generalNotifications;
  final bool streakNotifications;
  final bool achievementNotifications;
  final bool lessonReminders;
  final bool systemNotifications;
  final Time dailyReminderTime;
  final bool weekendReminders;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final int quietHoursStart;
  final int quietHoursEnd;

  const NotificationPreferences({
    this.generalNotifications = true,
    this.streakNotifications = true,
    this.achievementNotifications = true,
    this.lessonReminders = true,
    this.systemNotifications = true,
    this.dailyReminderTime = const Time(19, 0),
    this.weekendReminders = false,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.quietHoursStart = 22,
    this.quietHoursEnd = 8,
  });

  Map<String, dynamic> toMap() {
    return {
      'generalNotifications': generalNotifications,
      'streakNotifications': streakNotifications,
      'achievementNotifications': achievementNotifications,
      'lessonReminders': lessonReminders,
      'systemNotifications': systemNotifications,
      'dailyReminderTime': '${dailyReminderTime.hour.toString().padLeft(2, '0')}:${dailyReminderTime.minute.toString().padLeft(2, '0')}',
      'weekendReminders': weekendReminders,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'quietHoursStart': quietHoursStart,
      'quietHoursEnd': quietHoursEnd,
    };
  }

  factory NotificationPreferences.fromMap(Map<String, dynamic> map) {
    final timeString = map['dailyReminderTime'] as String? ?? '19:00';
    final parts = timeString.split(':');
    
    return NotificationPreferences(
      generalNotifications: map['generalNotifications'] as bool? ?? true,
      streakNotifications: map['streakNotifications'] as bool? ?? true,
      achievementNotifications: map['achievementNotifications'] as bool? ?? true,
      lessonReminders: map['lessonReminders'] as bool? ?? true,
      systemNotifications: map['systemNotifications'] as bool? ?? true,
      dailyReminderTime: Time(
        int.parse(parts[0]),
        int.parse(parts[1]),
      ),
      weekendReminders: map['weekendReminders'] as bool? ?? false,
      soundEnabled: map['soundEnabled'] as bool? ?? true,
      vibrationEnabled: map['vibrationEnabled'] as bool? ?? true,
      quietHoursStart: map['quietHoursStart'] as int? ?? 22,
      quietHoursEnd: map['quietHoursEnd'] as int? ?? 8,
    );
  }

  NotificationPreferences copyWith({
    bool? generalNotifications,
    bool? streakNotifications,
    bool? achievementNotifications,
    bool? lessonReminders,
    bool? systemNotifications,
    Time? dailyReminderTime,
    bool? weekendReminders,
    bool? soundEnabled,
    bool? vibrationEnabled,
    int? quietHoursStart,
    int? quietHoursEnd,
  }) {
    return NotificationPreferences(
      generalNotifications: generalNotifications ?? this.generalNotifications,
      streakNotifications: streakNotifications ?? this.streakNotifications,
      achievementNotifications: achievementNotifications ?? this.achievementNotifications,
      lessonReminders: lessonReminders ?? this.lessonReminders,
      systemNotifications: systemNotifications ?? this.systemNotifications,
      dailyReminderTime: dailyReminderTime ?? this.dailyReminderTime,
      weekendReminders: weekendReminders ?? this.weekendReminders,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
    );
  }
}

/// Helper class for Time handling
class Time {
  final int hour;
  final int minute;

  const Time(this.hour, this.minute);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Time && runtimeType == other.runtimeType && hour == other.hour && minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
