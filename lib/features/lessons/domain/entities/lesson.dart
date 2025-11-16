import 'package:equatable/equatable.dart';

enum CEFRLevel {
  a1('A1', 'Beginner'),
  a2('A2', 'Elementary'),
  b1('B1', 'Intermediate'),
  b2('B2', 'Upper Intermediate'),
  c1('C1', 'Advanced'),
  c2('C2', 'Proficient');

  const CEFRLevel(this.code, this.description);
  
  final String code;
  final String description;
  String get name => code; // Tambahkan getter untuk nama
}

enum LessonCategory {
  vocabulary('Vocabulary', 'Build your word bank'),
  grammar('Grammar', 'Master sentence structures'),
  pronunciation('Pronunciation', 'Perfect your accent'),
  phrases('Phrases', 'Common expressions'),
  conversation('Conversation', 'Practice speaking'),
  listening('Listening', 'Improve comprehension');

  const LessonCategory(this.name, this.description);
  
  final String name;
  final String description;
}

enum LessonType {
  vocabulary('Vocabulary'),
  grammar('Grammar'),
  pronunciation('Pronunciation'),
  phrase('Phrases'),
  dialogue('Dialogue'),
  exercise('Exercise');

  const LessonType(this.displayName);
  
  final String displayName;
}

class Lesson extends Equatable {
  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.category,
    required this.type,
    required this.duration,
    required this.difficulty,
    this.imageUrl,
    this.audioUrl,
    this.isPremium = false,
    this.isCompleted = false,
    this.progress = 0.0,
    this.bookmarked = false,
    this.rating = 0.0,
    this.totalRatings = 0,
    this.tags = const [],
    this.prerequisites = const [],
    this.createdAt,
    this.updatedAt,
    this.lastAccessed,
  });

  final String id;
  final String title;
  final String description;
  final CEFRLevel level;
  final LessonCategory category;
  final LessonType type;
  final int duration; // in minutes
  final double difficulty; // 0.0 to 1.0
  final String? imageUrl;
  final String? audioUrl;
  final bool isPremium;
  final bool isCompleted;
  final double progress; // 0.0 to 1.0
  final bool bookmarked;
  final double rating;
  final int totalRatings;
  final List<String> tags;
  final List<String> prerequisites;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastAccessed;

  Lesson copyWith({
    String? id,
    String? title,
    String? description,
    CEFRLevel? level,
    LessonCategory? category,
    LessonType? type,
    int? duration,
    double? difficulty,
    String? imageUrl,
    String? audioUrl,
    bool? isPremium,
    bool? isCompleted,
    double? progress,
    bool? bookmarked,
    double? rating,
    int? totalRatings,
    List<String>? tags,
    List<String>? prerequisites,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastAccessed,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      level: level ?? this.level,
      category: category ?? this.category,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      difficulty: difficulty ?? this.difficulty,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      isPremium: isPremium ?? this.isPremium,
      isCompleted: isCompleted ?? this.isCompleted,
      progress: progress ?? this.progress,
      bookmarked: bookmarked ?? this.bookmarked,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      tags: tags ?? this.tags,
      prerequisites: prerequisites ?? this.prerequisites,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastAccessed: lastAccessed ?? this.lastAccessed,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        level,
        category,
        type,
        duration,
        difficulty,
        imageUrl,
        audioUrl,
        isPremium,
        isCompleted,
        progress,
        bookmarked,
        rating,
        totalRatings,
        tags,
        prerequisites,
        createdAt,
        updatedAt,
        lastAccessed,
      ];

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title, level: $level, category: $category)';
  }
}
