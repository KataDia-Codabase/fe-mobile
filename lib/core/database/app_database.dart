import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Lessons,
  LessonContent,
  LessonProgress,
  Categories,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static AppDatabase create() {
    return AppDatabase();
  }

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'bahasaku.db'));
      return NativeDatabase(file);
    });
  }
}

// Table definitions

class Lessons extends Table {
  TextColumn get id => text()(); // Primary key
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get level => text()(); // CEFR level as string
  TextColumn get category => text()(); // Category as string
  TextColumn get type => text()(); // Lesson type as string
  IntColumn get duration => integer()(); // Duration in minutes
  RealColumn get difficulty => real()(); // Difficulty 0.0-1.0
  TextColumn get imageUrl => text().nullable()();
  TextColumn get audioUrl => text().nullable()();
  BoolColumn get isPremium => boolean().withDefault(const Constant(false))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  RealColumn get progress => real().withDefault(const Constant(0.0))(); // 0.0-1.0
  BoolColumn get bookmarked => boolean().withDefault(const Constant(false))();
  RealColumn get rating => real().withDefault(const Constant(0.0))();
  IntColumn get totalRatings => integer().withDefault(const Constant(0))();
  TextColumn get tags => text().withDefault(const Constant('[]'))(); // JSON array
  TextColumn get prerequisites => text().withDefault(const Constant('[]'))(); // JSON array
  
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get lastAccessed => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class LessonContent extends Table {
  TextColumn get id => text()(); // Primary key
  TextColumn get lessonId => text()(); // Foreign key to lessons
  TextColumn get title => text()();
  TextColumn get contentType => text()(); // Content type as string
  IntColumn get order => integer()(); // Order within lesson
  
  TextColumn get textContent => text().nullable()(); // Renamed from 'text'
  TextColumn get audioUrl => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get videoUrl => text().nullable()();
  TextColumn get interactiveData => text().nullable()(); // JSON data
  
  IntColumn get duration => integer().nullable()(); // Duration in seconds for audio/video
  TextColumn get phoneticTranscription => text().nullable()();
  TextColumn get translation => text().nullable()();
  RealColumn get difficulty => real().nullable()(); // Content-specific difficulty
  
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  RealColumn get userScore => real().nullable()(); // User's score on this content
  TextColumn get metadata => text().withDefault(const Constant('{}'))(); // JSON metadata

  @override
  Set<Column> get primaryKey => {id};
}

class LessonProgress extends Table {
  TextColumn get lessonId => text()(); // Composite primary key
  TextColumn get userId => text()(); // Composite primary key
  
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get lastAccessed => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get completionStatus => text().withDefault(const Constant('notStarted'))();
  RealColumn get overallScore => real().nullable()(); // Overall lesson score
  IntColumn get totalTimeSpent => integer().withDefault(const Constant(0))(); // In seconds
  TextColumn get contentProgress => text().withDefault(const Constant('[]'))(); // JSON array of content progress
  
  IntColumn get streakDays => integer().withDefault(const Constant(0))();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  BoolColumn get bookmarked => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();
  TextColumn get metadata => text().withDefault(const Constant('{}'))(); // JSON metadata

  @override
  Set<Column> get primaryKey => {lessonId, userId};
}

class Categories extends Table {
  TextColumn get id => text()(); // Primary key
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get iconUrl => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get color => text().nullable()(); // Hex color code
  
  IntColumn get lessonCount => integer().withDefault(const Constant(0))();
  IntColumn get totalDuration => integer().withDefault(const Constant(0))(); // In minutes
  TextColumn get levels => text().withDefault(const Constant('[]'))(); // JSON array of CEFR levels
  RealColumn get difficulty => real().nullable()(); // Average difficulty
  
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get featured => boolean().withDefault(const Constant(false))();
  
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
