// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LessonsTable extends Lessons with TableInfo<$LessonsTable, Lesson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
      'level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _audioUrlMeta =
      const VerificationMeta('audioUrl');
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
      'audio_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPremiumMeta =
      const VerificationMeta('isPremium');
  @override
  late final GeneratedColumn<bool> isPremium = GeneratedColumn<bool>(
      'is_premium', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_premium" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _bookmarkedMeta =
      const VerificationMeta('bookmarked');
  @override
  late final GeneratedColumn<bool> bookmarked = GeneratedColumn<bool>(
      'bookmarked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("bookmarked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalRatingsMeta =
      const VerificationMeta('totalRatings');
  @override
  late final GeneratedColumn<int> totalRatings = GeneratedColumn<int>(
      'total_ratings', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _prerequisitesMeta =
      const VerificationMeta('prerequisites');
  @override
  late final GeneratedColumn<String> prerequisites = GeneratedColumn<String>(
      'prerequisites', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastAccessedMeta =
      const VerificationMeta('lastAccessed');
  @override
  late final GeneratedColumn<DateTime> lastAccessed = GeneratedColumn<DateTime>(
      'last_accessed', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
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
        lastAccessed
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lessons';
  @override
  VerificationContext validateIntegrity(Insertable<Lesson> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('audio_url')) {
      context.handle(_audioUrlMeta,
          audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta));
    }
    if (data.containsKey('is_premium')) {
      context.handle(_isPremiumMeta,
          isPremium.isAcceptableOrUnknown(data['is_premium']!, _isPremiumMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    }
    if (data.containsKey('bookmarked')) {
      context.handle(
          _bookmarkedMeta,
          bookmarked.isAcceptableOrUnknown(
              data['bookmarked']!, _bookmarkedMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('total_ratings')) {
      context.handle(
          _totalRatingsMeta,
          totalRatings.isAcceptableOrUnknown(
              data['total_ratings']!, _totalRatingsMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('prerequisites')) {
      context.handle(
          _prerequisitesMeta,
          prerequisites.isAcceptableOrUnknown(
              data['prerequisites']!, _prerequisitesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('last_accessed')) {
      context.handle(
          _lastAccessedMeta,
          lastAccessed.isAcceptableOrUnknown(
              data['last_accessed']!, _lastAccessedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lesson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lesson(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}level'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difficulty'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      audioUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_url']),
      isPremium: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_premium'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress'])!,
      bookmarked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}bookmarked'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating'])!,
      totalRatings: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_ratings'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      prerequisites: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prerequisites'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      lastAccessed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_accessed']),
    );
  }

  @override
  $LessonsTable createAlias(String alias) {
    return $LessonsTable(attachedDatabase, alias);
  }
}

class Lesson extends DataClass implements Insertable<Lesson> {
  final String id;
  final String title;
  final String description;
  final String level;
  final String category;
  final String type;
  final int duration;
  final double difficulty;
  final String? imageUrl;
  final String? audioUrl;
  final bool isPremium;
  final bool isCompleted;
  final double progress;
  final bool bookmarked;
  final double rating;
  final int totalRatings;
  final String tags;
  final String prerequisites;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastAccessed;
  const Lesson(
      {required this.id,
      required this.title,
      required this.description,
      required this.level,
      required this.category,
      required this.type,
      required this.duration,
      required this.difficulty,
      this.imageUrl,
      this.audioUrl,
      required this.isPremium,
      required this.isCompleted,
      required this.progress,
      required this.bookmarked,
      required this.rating,
      required this.totalRatings,
      required this.tags,
      required this.prerequisites,
      this.createdAt,
      this.updatedAt,
      this.lastAccessed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['level'] = Variable<String>(level);
    map['category'] = Variable<String>(category);
    map['type'] = Variable<String>(type);
    map['duration'] = Variable<int>(duration);
    map['difficulty'] = Variable<double>(difficulty);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || audioUrl != null) {
      map['audio_url'] = Variable<String>(audioUrl);
    }
    map['is_premium'] = Variable<bool>(isPremium);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['progress'] = Variable<double>(progress);
    map['bookmarked'] = Variable<bool>(bookmarked);
    map['rating'] = Variable<double>(rating);
    map['total_ratings'] = Variable<int>(totalRatings);
    map['tags'] = Variable<String>(tags);
    map['prerequisites'] = Variable<String>(prerequisites);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || lastAccessed != null) {
      map['last_accessed'] = Variable<DateTime>(lastAccessed);
    }
    return map;
  }

  LessonsCompanion toCompanion(bool nullToAbsent) {
    return LessonsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      level: Value(level),
      category: Value(category),
      type: Value(type),
      duration: Value(duration),
      difficulty: Value(difficulty),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      audioUrl: audioUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioUrl),
      isPremium: Value(isPremium),
      isCompleted: Value(isCompleted),
      progress: Value(progress),
      bookmarked: Value(bookmarked),
      rating: Value(rating),
      totalRatings: Value(totalRatings),
      tags: Value(tags),
      prerequisites: Value(prerequisites),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      lastAccessed: lastAccessed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAccessed),
    );
  }

  factory Lesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lesson(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      level: serializer.fromJson<String>(json['level']),
      category: serializer.fromJson<String>(json['category']),
      type: serializer.fromJson<String>(json['type']),
      duration: serializer.fromJson<int>(json['duration']),
      difficulty: serializer.fromJson<double>(json['difficulty']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      audioUrl: serializer.fromJson<String?>(json['audioUrl']),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      progress: serializer.fromJson<double>(json['progress']),
      bookmarked: serializer.fromJson<bool>(json['bookmarked']),
      rating: serializer.fromJson<double>(json['rating']),
      totalRatings: serializer.fromJson<int>(json['totalRatings']),
      tags: serializer.fromJson<String>(json['tags']),
      prerequisites: serializer.fromJson<String>(json['prerequisites']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      lastAccessed: serializer.fromJson<DateTime?>(json['lastAccessed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'level': serializer.toJson<String>(level),
      'category': serializer.toJson<String>(category),
      'type': serializer.toJson<String>(type),
      'duration': serializer.toJson<int>(duration),
      'difficulty': serializer.toJson<double>(difficulty),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'audioUrl': serializer.toJson<String?>(audioUrl),
      'isPremium': serializer.toJson<bool>(isPremium),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'progress': serializer.toJson<double>(progress),
      'bookmarked': serializer.toJson<bool>(bookmarked),
      'rating': serializer.toJson<double>(rating),
      'totalRatings': serializer.toJson<int>(totalRatings),
      'tags': serializer.toJson<String>(tags),
      'prerequisites': serializer.toJson<String>(prerequisites),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'lastAccessed': serializer.toJson<DateTime?>(lastAccessed),
    };
  }

  Lesson copyWith(
          {String? id,
          String? title,
          String? description,
          String? level,
          String? category,
          String? type,
          int? duration,
          double? difficulty,
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> audioUrl = const Value.absent(),
          bool? isPremium,
          bool? isCompleted,
          double? progress,
          bool? bookmarked,
          double? rating,
          int? totalRatings,
          String? tags,
          String? prerequisites,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<DateTime?> lastAccessed = const Value.absent()}) =>
      Lesson(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        level: level ?? this.level,
        category: category ?? this.category,
        type: type ?? this.type,
        duration: duration ?? this.duration,
        difficulty: difficulty ?? this.difficulty,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        audioUrl: audioUrl.present ? audioUrl.value : this.audioUrl,
        isPremium: isPremium ?? this.isPremium,
        isCompleted: isCompleted ?? this.isCompleted,
        progress: progress ?? this.progress,
        bookmarked: bookmarked ?? this.bookmarked,
        rating: rating ?? this.rating,
        totalRatings: totalRatings ?? this.totalRatings,
        tags: tags ?? this.tags,
        prerequisites: prerequisites ?? this.prerequisites,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        lastAccessed:
            lastAccessed.present ? lastAccessed.value : this.lastAccessed,
      );
  Lesson copyWithCompanion(LessonsCompanion data) {
    return Lesson(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      level: data.level.present ? data.level.value : this.level,
      category: data.category.present ? data.category.value : this.category,
      type: data.type.present ? data.type.value : this.type,
      duration: data.duration.present ? data.duration.value : this.duration,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      progress: data.progress.present ? data.progress.value : this.progress,
      bookmarked:
          data.bookmarked.present ? data.bookmarked.value : this.bookmarked,
      rating: data.rating.present ? data.rating.value : this.rating,
      totalRatings: data.totalRatings.present
          ? data.totalRatings.value
          : this.totalRatings,
      tags: data.tags.present ? data.tags.value : this.tags,
      prerequisites: data.prerequisites.present
          ? data.prerequisites.value
          : this.prerequisites,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastAccessed: data.lastAccessed.present
          ? data.lastAccessed.value
          : this.lastAccessed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lesson(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('level: $level, ')
          ..write('category: $category, ')
          ..write('type: $type, ')
          ..write('duration: $duration, ')
          ..write('difficulty: $difficulty, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('isPremium: $isPremium, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('progress: $progress, ')
          ..write('bookmarked: $bookmarked, ')
          ..write('rating: $rating, ')
          ..write('totalRatings: $totalRatings, ')
          ..write('tags: $tags, ')
          ..write('prerequisites: $prerequisites, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastAccessed: $lastAccessed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
        lastAccessed
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lesson &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.level == this.level &&
          other.category == this.category &&
          other.type == this.type &&
          other.duration == this.duration &&
          other.difficulty == this.difficulty &&
          other.imageUrl == this.imageUrl &&
          other.audioUrl == this.audioUrl &&
          other.isPremium == this.isPremium &&
          other.isCompleted == this.isCompleted &&
          other.progress == this.progress &&
          other.bookmarked == this.bookmarked &&
          other.rating == this.rating &&
          other.totalRatings == this.totalRatings &&
          other.tags == this.tags &&
          other.prerequisites == this.prerequisites &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastAccessed == this.lastAccessed);
}

class LessonsCompanion extends UpdateCompanion<Lesson> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> level;
  final Value<String> category;
  final Value<String> type;
  final Value<int> duration;
  final Value<double> difficulty;
  final Value<String?> imageUrl;
  final Value<String?> audioUrl;
  final Value<bool> isPremium;
  final Value<bool> isCompleted;
  final Value<double> progress;
  final Value<bool> bookmarked;
  final Value<double> rating;
  final Value<int> totalRatings;
  final Value<String> tags;
  final Value<String> prerequisites;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> lastAccessed;
  final Value<int> rowid;
  const LessonsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.level = const Value.absent(),
    this.category = const Value.absent(),
    this.type = const Value.absent(),
    this.duration = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.progress = const Value.absent(),
    this.bookmarked = const Value.absent(),
    this.rating = const Value.absent(),
    this.totalRatings = const Value.absent(),
    this.tags = const Value.absent(),
    this.prerequisites = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LessonsCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String level,
    required String category,
    required String type,
    required int duration,
    required double difficulty,
    this.imageUrl = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.progress = const Value.absent(),
    this.bookmarked = const Value.absent(),
    this.rating = const Value.absent(),
    this.totalRatings = const Value.absent(),
    this.tags = const Value.absent(),
    this.prerequisites = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        description = Value(description),
        level = Value(level),
        category = Value(category),
        type = Value(type),
        duration = Value(duration),
        difficulty = Value(difficulty);
  static Insertable<Lesson> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? level,
    Expression<String>? category,
    Expression<String>? type,
    Expression<int>? duration,
    Expression<double>? difficulty,
    Expression<String>? imageUrl,
    Expression<String>? audioUrl,
    Expression<bool>? isPremium,
    Expression<bool>? isCompleted,
    Expression<double>? progress,
    Expression<bool>? bookmarked,
    Expression<double>? rating,
    Expression<int>? totalRatings,
    Expression<String>? tags,
    Expression<String>? prerequisites,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastAccessed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (level != null) 'level': level,
      if (category != null) 'category': category,
      if (type != null) 'type': type,
      if (duration != null) 'duration': duration,
      if (difficulty != null) 'difficulty': difficulty,
      if (imageUrl != null) 'image_url': imageUrl,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (isPremium != null) 'is_premium': isPremium,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (progress != null) 'progress': progress,
      if (bookmarked != null) 'bookmarked': bookmarked,
      if (rating != null) 'rating': rating,
      if (totalRatings != null) 'total_ratings': totalRatings,
      if (tags != null) 'tags': tags,
      if (prerequisites != null) 'prerequisites': prerequisites,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastAccessed != null) 'last_accessed': lastAccessed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LessonsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? description,
      Value<String>? level,
      Value<String>? category,
      Value<String>? type,
      Value<int>? duration,
      Value<double>? difficulty,
      Value<String?>? imageUrl,
      Value<String?>? audioUrl,
      Value<bool>? isPremium,
      Value<bool>? isCompleted,
      Value<double>? progress,
      Value<bool>? bookmarked,
      Value<double>? rating,
      Value<int>? totalRatings,
      Value<String>? tags,
      Value<String>? prerequisites,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<DateTime?>? lastAccessed,
      Value<int>? rowid}) {
    return LessonsCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (bookmarked.present) {
      map['bookmarked'] = Variable<bool>(bookmarked.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (totalRatings.present) {
      map['total_ratings'] = Variable<int>(totalRatings.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (prerequisites.present) {
      map['prerequisites'] = Variable<String>(prerequisites.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastAccessed.present) {
      map['last_accessed'] = Variable<DateTime>(lastAccessed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('level: $level, ')
          ..write('category: $category, ')
          ..write('type: $type, ')
          ..write('duration: $duration, ')
          ..write('difficulty: $difficulty, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('isPremium: $isPremium, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('progress: $progress, ')
          ..write('bookmarked: $bookmarked, ')
          ..write('rating: $rating, ')
          ..write('totalRatings: $totalRatings, ')
          ..write('tags: $tags, ')
          ..write('prerequisites: $prerequisites, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastAccessed: $lastAccessed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LessonContentTable extends LessonContent
    with TableInfo<$LessonContentTable, LessonContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonContentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lessonIdMeta =
      const VerificationMeta('lessonId');
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
      'lesson_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentTypeMeta =
      const VerificationMeta('contentType');
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
      'content_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textContentMeta =
      const VerificationMeta('textContent');
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
      'text_content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _audioUrlMeta =
      const VerificationMeta('audioUrl');
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
      'audio_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _videoUrlMeta =
      const VerificationMeta('videoUrl');
  @override
  late final GeneratedColumn<String> videoUrl = GeneratedColumn<String>(
      'video_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _interactiveDataMeta =
      const VerificationMeta('interactiveData');
  @override
  late final GeneratedColumn<String> interactiveData = GeneratedColumn<String>(
      'interactive_data', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _phoneticTranscriptionMeta =
      const VerificationMeta('phoneticTranscription');
  @override
  late final GeneratedColumn<String> phoneticTranscription =
      GeneratedColumn<String>('phonetic_transcription', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _translationMeta =
      const VerificationMeta('translation');
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
      'translation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
      'difficulty', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _userScoreMeta =
      const VerificationMeta('userScore');
  @override
  late final GeneratedColumn<double> userScore = GeneratedColumn<double>(
      'user_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lessonId,
        title,
        contentType,
        order,
        textContent,
        audioUrl,
        imageUrl,
        videoUrl,
        interactiveData,
        duration,
        phoneticTranscription,
        translation,
        difficulty,
        isCompleted,
        userScore,
        metadata
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_content';
  @override
  VerificationContext validateIntegrity(Insertable<LessonContentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lesson_id')) {
      context.handle(_lessonIdMeta,
          lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta));
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
          _contentTypeMeta,
          contentType.isAcceptableOrUnknown(
              data['content_type']!, _contentTypeMeta));
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('text_content')) {
      context.handle(
          _textContentMeta,
          textContent.isAcceptableOrUnknown(
              data['text_content']!, _textContentMeta));
    }
    if (data.containsKey('audio_url')) {
      context.handle(_audioUrlMeta,
          audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('video_url')) {
      context.handle(_videoUrlMeta,
          videoUrl.isAcceptableOrUnknown(data['video_url']!, _videoUrlMeta));
    }
    if (data.containsKey('interactive_data')) {
      context.handle(
          _interactiveDataMeta,
          interactiveData.isAcceptableOrUnknown(
              data['interactive_data']!, _interactiveDataMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    if (data.containsKey('phonetic_transcription')) {
      context.handle(
          _phoneticTranscriptionMeta,
          phoneticTranscription.isAcceptableOrUnknown(
              data['phonetic_transcription']!, _phoneticTranscriptionMeta));
    }
    if (data.containsKey('translation')) {
      context.handle(
          _translationMeta,
          translation.isAcceptableOrUnknown(
              data['translation']!, _translationMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('user_score')) {
      context.handle(_userScoreMeta,
          userScore.isAcceptableOrUnknown(data['user_score']!, _userScoreMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LessonContentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonContentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      contentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_type'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      textContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_content']),
      audioUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_url']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      videoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}video_url']),
      interactiveData: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}interactive_data']),
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration']),
      phoneticTranscription: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}phonetic_transcription']),
      translation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}translation']),
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difficulty']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      userScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}user_score']),
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata'])!,
    );
  }

  @override
  $LessonContentTable createAlias(String alias) {
    return $LessonContentTable(attachedDatabase, alias);
  }
}

class LessonContentData extends DataClass
    implements Insertable<LessonContentData> {
  final String id;
  final String lessonId;
  final String title;
  final String contentType;
  final int order;
  final String? textContent;
  final String? audioUrl;
  final String? imageUrl;
  final String? videoUrl;
  final String? interactiveData;
  final int? duration;
  final String? phoneticTranscription;
  final String? translation;
  final double? difficulty;
  final bool isCompleted;
  final double? userScore;
  final String metadata;
  const LessonContentData(
      {required this.id,
      required this.lessonId,
      required this.title,
      required this.contentType,
      required this.order,
      this.textContent,
      this.audioUrl,
      this.imageUrl,
      this.videoUrl,
      this.interactiveData,
      this.duration,
      this.phoneticTranscription,
      this.translation,
      this.difficulty,
      required this.isCompleted,
      this.userScore,
      required this.metadata});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lesson_id'] = Variable<String>(lessonId);
    map['title'] = Variable<String>(title);
    map['content_type'] = Variable<String>(contentType);
    map['order'] = Variable<int>(order);
    if (!nullToAbsent || textContent != null) {
      map['text_content'] = Variable<String>(textContent);
    }
    if (!nullToAbsent || audioUrl != null) {
      map['audio_url'] = Variable<String>(audioUrl);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || videoUrl != null) {
      map['video_url'] = Variable<String>(videoUrl);
    }
    if (!nullToAbsent || interactiveData != null) {
      map['interactive_data'] = Variable<String>(interactiveData);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || phoneticTranscription != null) {
      map['phonetic_transcription'] = Variable<String>(phoneticTranscription);
    }
    if (!nullToAbsent || translation != null) {
      map['translation'] = Variable<String>(translation);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<double>(difficulty);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || userScore != null) {
      map['user_score'] = Variable<double>(userScore);
    }
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  LessonContentCompanion toCompanion(bool nullToAbsent) {
    return LessonContentCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      title: Value(title),
      contentType: Value(contentType),
      order: Value(order),
      textContent: textContent == null && nullToAbsent
          ? const Value.absent()
          : Value(textContent),
      audioUrl: audioUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioUrl),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      videoUrl: videoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(videoUrl),
      interactiveData: interactiveData == null && nullToAbsent
          ? const Value.absent()
          : Value(interactiveData),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      phoneticTranscription: phoneticTranscription == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneticTranscription),
      translation: translation == null && nullToAbsent
          ? const Value.absent()
          : Value(translation),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      isCompleted: Value(isCompleted),
      userScore: userScore == null && nullToAbsent
          ? const Value.absent()
          : Value(userScore),
      metadata: Value(metadata),
    );
  }

  factory LessonContentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonContentData(
      id: serializer.fromJson<String>(json['id']),
      lessonId: serializer.fromJson<String>(json['lessonId']),
      title: serializer.fromJson<String>(json['title']),
      contentType: serializer.fromJson<String>(json['contentType']),
      order: serializer.fromJson<int>(json['order']),
      textContent: serializer.fromJson<String?>(json['textContent']),
      audioUrl: serializer.fromJson<String?>(json['audioUrl']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      videoUrl: serializer.fromJson<String?>(json['videoUrl']),
      interactiveData: serializer.fromJson<String?>(json['interactiveData']),
      duration: serializer.fromJson<int?>(json['duration']),
      phoneticTranscription:
          serializer.fromJson<String?>(json['phoneticTranscription']),
      translation: serializer.fromJson<String?>(json['translation']),
      difficulty: serializer.fromJson<double?>(json['difficulty']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      userScore: serializer.fromJson<double?>(json['userScore']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lessonId': serializer.toJson<String>(lessonId),
      'title': serializer.toJson<String>(title),
      'contentType': serializer.toJson<String>(contentType),
      'order': serializer.toJson<int>(order),
      'textContent': serializer.toJson<String?>(textContent),
      'audioUrl': serializer.toJson<String?>(audioUrl),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'videoUrl': serializer.toJson<String?>(videoUrl),
      'interactiveData': serializer.toJson<String?>(interactiveData),
      'duration': serializer.toJson<int?>(duration),
      'phoneticTranscription':
          serializer.toJson<String?>(phoneticTranscription),
      'translation': serializer.toJson<String?>(translation),
      'difficulty': serializer.toJson<double?>(difficulty),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'userScore': serializer.toJson<double?>(userScore),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  LessonContentData copyWith(
          {String? id,
          String? lessonId,
          String? title,
          String? contentType,
          int? order,
          Value<String?> textContent = const Value.absent(),
          Value<String?> audioUrl = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> videoUrl = const Value.absent(),
          Value<String?> interactiveData = const Value.absent(),
          Value<int?> duration = const Value.absent(),
          Value<String?> phoneticTranscription = const Value.absent(),
          Value<String?> translation = const Value.absent(),
          Value<double?> difficulty = const Value.absent(),
          bool? isCompleted,
          Value<double?> userScore = const Value.absent(),
          String? metadata}) =>
      LessonContentData(
        id: id ?? this.id,
        lessonId: lessonId ?? this.lessonId,
        title: title ?? this.title,
        contentType: contentType ?? this.contentType,
        order: order ?? this.order,
        textContent: textContent.present ? textContent.value : this.textContent,
        audioUrl: audioUrl.present ? audioUrl.value : this.audioUrl,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        videoUrl: videoUrl.present ? videoUrl.value : this.videoUrl,
        interactiveData: interactiveData.present
            ? interactiveData.value
            : this.interactiveData,
        duration: duration.present ? duration.value : this.duration,
        phoneticTranscription: phoneticTranscription.present
            ? phoneticTranscription.value
            : this.phoneticTranscription,
        translation: translation.present ? translation.value : this.translation,
        difficulty: difficulty.present ? difficulty.value : this.difficulty,
        isCompleted: isCompleted ?? this.isCompleted,
        userScore: userScore.present ? userScore.value : this.userScore,
        metadata: metadata ?? this.metadata,
      );
  LessonContentData copyWithCompanion(LessonContentCompanion data) {
    return LessonContentData(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      title: data.title.present ? data.title.value : this.title,
      contentType:
          data.contentType.present ? data.contentType.value : this.contentType,
      order: data.order.present ? data.order.value : this.order,
      textContent:
          data.textContent.present ? data.textContent.value : this.textContent,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      videoUrl: data.videoUrl.present ? data.videoUrl.value : this.videoUrl,
      interactiveData: data.interactiveData.present
          ? data.interactiveData.value
          : this.interactiveData,
      duration: data.duration.present ? data.duration.value : this.duration,
      phoneticTranscription: data.phoneticTranscription.present
          ? data.phoneticTranscription.value
          : this.phoneticTranscription,
      translation:
          data.translation.present ? data.translation.value : this.translation,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      userScore: data.userScore.present ? data.userScore.value : this.userScore,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonContentData(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('title: $title, ')
          ..write('contentType: $contentType, ')
          ..write('order: $order, ')
          ..write('textContent: $textContent, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('interactiveData: $interactiveData, ')
          ..write('duration: $duration, ')
          ..write('phoneticTranscription: $phoneticTranscription, ')
          ..write('translation: $translation, ')
          ..write('difficulty: $difficulty, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('userScore: $userScore, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      lessonId,
      title,
      contentType,
      order,
      textContent,
      audioUrl,
      imageUrl,
      videoUrl,
      interactiveData,
      duration,
      phoneticTranscription,
      translation,
      difficulty,
      isCompleted,
      userScore,
      metadata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonContentData &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.title == this.title &&
          other.contentType == this.contentType &&
          other.order == this.order &&
          other.textContent == this.textContent &&
          other.audioUrl == this.audioUrl &&
          other.imageUrl == this.imageUrl &&
          other.videoUrl == this.videoUrl &&
          other.interactiveData == this.interactiveData &&
          other.duration == this.duration &&
          other.phoneticTranscription == this.phoneticTranscription &&
          other.translation == this.translation &&
          other.difficulty == this.difficulty &&
          other.isCompleted == this.isCompleted &&
          other.userScore == this.userScore &&
          other.metadata == this.metadata);
}

class LessonContentCompanion extends UpdateCompanion<LessonContentData> {
  final Value<String> id;
  final Value<String> lessonId;
  final Value<String> title;
  final Value<String> contentType;
  final Value<int> order;
  final Value<String?> textContent;
  final Value<String?> audioUrl;
  final Value<String?> imageUrl;
  final Value<String?> videoUrl;
  final Value<String?> interactiveData;
  final Value<int?> duration;
  final Value<String?> phoneticTranscription;
  final Value<String?> translation;
  final Value<double?> difficulty;
  final Value<bool> isCompleted;
  final Value<double?> userScore;
  final Value<String> metadata;
  final Value<int> rowid;
  const LessonContentCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.title = const Value.absent(),
    this.contentType = const Value.absent(),
    this.order = const Value.absent(),
    this.textContent = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.interactiveData = const Value.absent(),
    this.duration = const Value.absent(),
    this.phoneticTranscription = const Value.absent(),
    this.translation = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.userScore = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LessonContentCompanion.insert({
    required String id,
    required String lessonId,
    required String title,
    required String contentType,
    required int order,
    this.textContent = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.interactiveData = const Value.absent(),
    this.duration = const Value.absent(),
    this.phoneticTranscription = const Value.absent(),
    this.translation = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.userScore = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        lessonId = Value(lessonId),
        title = Value(title),
        contentType = Value(contentType),
        order = Value(order);
  static Insertable<LessonContentData> custom({
    Expression<String>? id,
    Expression<String>? lessonId,
    Expression<String>? title,
    Expression<String>? contentType,
    Expression<int>? order,
    Expression<String>? textContent,
    Expression<String>? audioUrl,
    Expression<String>? imageUrl,
    Expression<String>? videoUrl,
    Expression<String>? interactiveData,
    Expression<int>? duration,
    Expression<String>? phoneticTranscription,
    Expression<String>? translation,
    Expression<double>? difficulty,
    Expression<bool>? isCompleted,
    Expression<double>? userScore,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (title != null) 'title': title,
      if (contentType != null) 'content_type': contentType,
      if (order != null) 'order': order,
      if (textContent != null) 'text_content': textContent,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (imageUrl != null) 'image_url': imageUrl,
      if (videoUrl != null) 'video_url': videoUrl,
      if (interactiveData != null) 'interactive_data': interactiveData,
      if (duration != null) 'duration': duration,
      if (phoneticTranscription != null)
        'phonetic_transcription': phoneticTranscription,
      if (translation != null) 'translation': translation,
      if (difficulty != null) 'difficulty': difficulty,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (userScore != null) 'user_score': userScore,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LessonContentCompanion copyWith(
      {Value<String>? id,
      Value<String>? lessonId,
      Value<String>? title,
      Value<String>? contentType,
      Value<int>? order,
      Value<String?>? textContent,
      Value<String?>? audioUrl,
      Value<String?>? imageUrl,
      Value<String?>? videoUrl,
      Value<String?>? interactiveData,
      Value<int?>? duration,
      Value<String?>? phoneticTranscription,
      Value<String?>? translation,
      Value<double?>? difficulty,
      Value<bool>? isCompleted,
      Value<double?>? userScore,
      Value<String>? metadata,
      Value<int>? rowid}) {
    return LessonContentCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      title: title ?? this.title,
      contentType: contentType ?? this.contentType,
      order: order ?? this.order,
      textContent: textContent ?? this.textContent,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      interactiveData: interactiveData ?? this.interactiveData,
      duration: duration ?? this.duration,
      phoneticTranscription:
          phoneticTranscription ?? this.phoneticTranscription,
      translation: translation ?? this.translation,
      difficulty: difficulty ?? this.difficulty,
      isCompleted: isCompleted ?? this.isCompleted,
      userScore: userScore ?? this.userScore,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (videoUrl.present) {
      map['video_url'] = Variable<String>(videoUrl.value);
    }
    if (interactiveData.present) {
      map['interactive_data'] = Variable<String>(interactiveData.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (phoneticTranscription.present) {
      map['phonetic_transcription'] =
          Variable<String>(phoneticTranscription.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (userScore.present) {
      map['user_score'] = Variable<double>(userScore.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonContentCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('title: $title, ')
          ..write('contentType: $contentType, ')
          ..write('order: $order, ')
          ..write('textContent: $textContent, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('interactiveData: $interactiveData, ')
          ..write('duration: $duration, ')
          ..write('phoneticTranscription: $phoneticTranscription, ')
          ..write('translation: $translation, ')
          ..write('difficulty: $difficulty, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('userScore: $userScore, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LessonProgressTable extends LessonProgress
    with TableInfo<$LessonProgressTable, LessonProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _lessonIdMeta =
      const VerificationMeta('lessonId');
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
      'lesson_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastAccessedMeta =
      const VerificationMeta('lastAccessed');
  @override
  late final GeneratedColumn<DateTime> lastAccessed = GeneratedColumn<DateTime>(
      'last_accessed', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completionStatusMeta =
      const VerificationMeta('completionStatus');
  @override
  late final GeneratedColumn<String> completionStatus = GeneratedColumn<String>(
      'completion_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('notStarted'));
  static const VerificationMeta _overallScoreMeta =
      const VerificationMeta('overallScore');
  @override
  late final GeneratedColumn<double> overallScore = GeneratedColumn<double>(
      'overall_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _totalTimeSpentMeta =
      const VerificationMeta('totalTimeSpent');
  @override
  late final GeneratedColumn<int> totalTimeSpent = GeneratedColumn<int>(
      'total_time_spent', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _contentProgressMeta =
      const VerificationMeta('contentProgress');
  @override
  late final GeneratedColumn<String> contentProgress = GeneratedColumn<String>(
      'content_progress', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _streakDaysMeta =
      const VerificationMeta('streakDays');
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
      'streak_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _attemptsMeta =
      const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
      'attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _bookmarkedMeta =
      const VerificationMeta('bookmarked');
  @override
  late final GeneratedColumn<bool> bookmarked = GeneratedColumn<bool>(
      'bookmarked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("bookmarked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  @override
  List<GeneratedColumn> get $columns => [
        lessonId,
        userId,
        startedAt,
        lastAccessed,
        completedAt,
        completionStatus,
        overallScore,
        totalTimeSpent,
        contentProgress,
        streakDays,
        attempts,
        bookmarked,
        notes,
        metadata
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_progress';
  @override
  VerificationContext validateIntegrity(Insertable<LessonProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('lesson_id')) {
      context.handle(_lessonIdMeta,
          lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta));
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('last_accessed')) {
      context.handle(
          _lastAccessedMeta,
          lastAccessed.isAcceptableOrUnknown(
              data['last_accessed']!, _lastAccessedMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('completion_status')) {
      context.handle(
          _completionStatusMeta,
          completionStatus.isAcceptableOrUnknown(
              data['completion_status']!, _completionStatusMeta));
    }
    if (data.containsKey('overall_score')) {
      context.handle(
          _overallScoreMeta,
          overallScore.isAcceptableOrUnknown(
              data['overall_score']!, _overallScoreMeta));
    }
    if (data.containsKey('total_time_spent')) {
      context.handle(
          _totalTimeSpentMeta,
          totalTimeSpent.isAcceptableOrUnknown(
              data['total_time_spent']!, _totalTimeSpentMeta));
    }
    if (data.containsKey('content_progress')) {
      context.handle(
          _contentProgressMeta,
          contentProgress.isAcceptableOrUnknown(
              data['content_progress']!, _contentProgressMeta));
    }
    if (data.containsKey('streak_days')) {
      context.handle(
          _streakDaysMeta,
          streakDays.isAcceptableOrUnknown(
              data['streak_days']!, _streakDaysMeta));
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta,
          attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    if (data.containsKey('bookmarked')) {
      context.handle(
          _bookmarkedMeta,
          bookmarked.isAcceptableOrUnknown(
              data['bookmarked']!, _bookmarkedMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {lessonId, userId};
  @override
  LessonProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonProgressData(
      lessonId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at']),
      lastAccessed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_accessed']),
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      completionStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}completion_status'])!,
      overallScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}overall_score']),
      totalTimeSpent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_time_spent'])!,
      contentProgress: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}content_progress'])!,
      streakDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_days'])!,
      attempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      bookmarked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}bookmarked'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata'])!,
    );
  }

  @override
  $LessonProgressTable createAlias(String alias) {
    return $LessonProgressTable(attachedDatabase, alias);
  }
}

class LessonProgressData extends DataClass
    implements Insertable<LessonProgressData> {
  final String lessonId;
  final String userId;
  final DateTime? startedAt;
  final DateTime? lastAccessed;
  final DateTime? completedAt;
  final String completionStatus;
  final double? overallScore;
  final int totalTimeSpent;
  final String contentProgress;
  final int streakDays;
  final int attempts;
  final bool bookmarked;
  final String? notes;
  final String metadata;
  const LessonProgressData(
      {required this.lessonId,
      required this.userId,
      this.startedAt,
      this.lastAccessed,
      this.completedAt,
      required this.completionStatus,
      this.overallScore,
      required this.totalTimeSpent,
      required this.contentProgress,
      required this.streakDays,
      required this.attempts,
      required this.bookmarked,
      this.notes,
      required this.metadata});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['lesson_id'] = Variable<String>(lessonId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || lastAccessed != null) {
      map['last_accessed'] = Variable<DateTime>(lastAccessed);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['completion_status'] = Variable<String>(completionStatus);
    if (!nullToAbsent || overallScore != null) {
      map['overall_score'] = Variable<double>(overallScore);
    }
    map['total_time_spent'] = Variable<int>(totalTimeSpent);
    map['content_progress'] = Variable<String>(contentProgress);
    map['streak_days'] = Variable<int>(streakDays);
    map['attempts'] = Variable<int>(attempts);
    map['bookmarked'] = Variable<bool>(bookmarked);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  LessonProgressCompanion toCompanion(bool nullToAbsent) {
    return LessonProgressCompanion(
      lessonId: Value(lessonId),
      userId: Value(userId),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      lastAccessed: lastAccessed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAccessed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      completionStatus: Value(completionStatus),
      overallScore: overallScore == null && nullToAbsent
          ? const Value.absent()
          : Value(overallScore),
      totalTimeSpent: Value(totalTimeSpent),
      contentProgress: Value(contentProgress),
      streakDays: Value(streakDays),
      attempts: Value(attempts),
      bookmarked: Value(bookmarked),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      metadata: Value(metadata),
    );
  }

  factory LessonProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonProgressData(
      lessonId: serializer.fromJson<String>(json['lessonId']),
      userId: serializer.fromJson<String>(json['userId']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      lastAccessed: serializer.fromJson<DateTime?>(json['lastAccessed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      completionStatus: serializer.fromJson<String>(json['completionStatus']),
      overallScore: serializer.fromJson<double?>(json['overallScore']),
      totalTimeSpent: serializer.fromJson<int>(json['totalTimeSpent']),
      contentProgress: serializer.fromJson<String>(json['contentProgress']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      attempts: serializer.fromJson<int>(json['attempts']),
      bookmarked: serializer.fromJson<bool>(json['bookmarked']),
      notes: serializer.fromJson<String?>(json['notes']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lessonId': serializer.toJson<String>(lessonId),
      'userId': serializer.toJson<String>(userId),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'lastAccessed': serializer.toJson<DateTime?>(lastAccessed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'completionStatus': serializer.toJson<String>(completionStatus),
      'overallScore': serializer.toJson<double?>(overallScore),
      'totalTimeSpent': serializer.toJson<int>(totalTimeSpent),
      'contentProgress': serializer.toJson<String>(contentProgress),
      'streakDays': serializer.toJson<int>(streakDays),
      'attempts': serializer.toJson<int>(attempts),
      'bookmarked': serializer.toJson<bool>(bookmarked),
      'notes': serializer.toJson<String?>(notes),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  LessonProgressData copyWith(
          {String? lessonId,
          String? userId,
          Value<DateTime?> startedAt = const Value.absent(),
          Value<DateTime?> lastAccessed = const Value.absent(),
          Value<DateTime?> completedAt = const Value.absent(),
          String? completionStatus,
          Value<double?> overallScore = const Value.absent(),
          int? totalTimeSpent,
          String? contentProgress,
          int? streakDays,
          int? attempts,
          bool? bookmarked,
          Value<String?> notes = const Value.absent(),
          String? metadata}) =>
      LessonProgressData(
        lessonId: lessonId ?? this.lessonId,
        userId: userId ?? this.userId,
        startedAt: startedAt.present ? startedAt.value : this.startedAt,
        lastAccessed:
            lastAccessed.present ? lastAccessed.value : this.lastAccessed,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        completionStatus: completionStatus ?? this.completionStatus,
        overallScore:
            overallScore.present ? overallScore.value : this.overallScore,
        totalTimeSpent: totalTimeSpent ?? this.totalTimeSpent,
        contentProgress: contentProgress ?? this.contentProgress,
        streakDays: streakDays ?? this.streakDays,
        attempts: attempts ?? this.attempts,
        bookmarked: bookmarked ?? this.bookmarked,
        notes: notes.present ? notes.value : this.notes,
        metadata: metadata ?? this.metadata,
      );
  LessonProgressData copyWithCompanion(LessonProgressCompanion data) {
    return LessonProgressData(
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      userId: data.userId.present ? data.userId.value : this.userId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      lastAccessed: data.lastAccessed.present
          ? data.lastAccessed.value
          : this.lastAccessed,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      completionStatus: data.completionStatus.present
          ? data.completionStatus.value
          : this.completionStatus,
      overallScore: data.overallScore.present
          ? data.overallScore.value
          : this.overallScore,
      totalTimeSpent: data.totalTimeSpent.present
          ? data.totalTimeSpent.value
          : this.totalTimeSpent,
      contentProgress: data.contentProgress.present
          ? data.contentProgress.value
          : this.contentProgress,
      streakDays:
          data.streakDays.present ? data.streakDays.value : this.streakDays,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      bookmarked:
          data.bookmarked.present ? data.bookmarked.value : this.bookmarked,
      notes: data.notes.present ? data.notes.value : this.notes,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressData(')
          ..write('lessonId: $lessonId, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('lastAccessed: $lastAccessed, ')
          ..write('completedAt: $completedAt, ')
          ..write('completionStatus: $completionStatus, ')
          ..write('overallScore: $overallScore, ')
          ..write('totalTimeSpent: $totalTimeSpent, ')
          ..write('contentProgress: $contentProgress, ')
          ..write('streakDays: $streakDays, ')
          ..write('attempts: $attempts, ')
          ..write('bookmarked: $bookmarked, ')
          ..write('notes: $notes, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      lessonId,
      userId,
      startedAt,
      lastAccessed,
      completedAt,
      completionStatus,
      overallScore,
      totalTimeSpent,
      contentProgress,
      streakDays,
      attempts,
      bookmarked,
      notes,
      metadata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonProgressData &&
          other.lessonId == this.lessonId &&
          other.userId == this.userId &&
          other.startedAt == this.startedAt &&
          other.lastAccessed == this.lastAccessed &&
          other.completedAt == this.completedAt &&
          other.completionStatus == this.completionStatus &&
          other.overallScore == this.overallScore &&
          other.totalTimeSpent == this.totalTimeSpent &&
          other.contentProgress == this.contentProgress &&
          other.streakDays == this.streakDays &&
          other.attempts == this.attempts &&
          other.bookmarked == this.bookmarked &&
          other.notes == this.notes &&
          other.metadata == this.metadata);
}

class LessonProgressCompanion extends UpdateCompanion<LessonProgressData> {
  final Value<String> lessonId;
  final Value<String> userId;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> lastAccessed;
  final Value<DateTime?> completedAt;
  final Value<String> completionStatus;
  final Value<double?> overallScore;
  final Value<int> totalTimeSpent;
  final Value<String> contentProgress;
  final Value<int> streakDays;
  final Value<int> attempts;
  final Value<bool> bookmarked;
  final Value<String?> notes;
  final Value<String> metadata;
  final Value<int> rowid;
  const LessonProgressCompanion({
    this.lessonId = const Value.absent(),
    this.userId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.completionStatus = const Value.absent(),
    this.overallScore = const Value.absent(),
    this.totalTimeSpent = const Value.absent(),
    this.contentProgress = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.attempts = const Value.absent(),
    this.bookmarked = const Value.absent(),
    this.notes = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LessonProgressCompanion.insert({
    required String lessonId,
    required String userId,
    this.startedAt = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.completionStatus = const Value.absent(),
    this.overallScore = const Value.absent(),
    this.totalTimeSpent = const Value.absent(),
    this.contentProgress = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.attempts = const Value.absent(),
    this.bookmarked = const Value.absent(),
    this.notes = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : lessonId = Value(lessonId),
        userId = Value(userId);
  static Insertable<LessonProgressData> custom({
    Expression<String>? lessonId,
    Expression<String>? userId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? lastAccessed,
    Expression<DateTime>? completedAt,
    Expression<String>? completionStatus,
    Expression<double>? overallScore,
    Expression<int>? totalTimeSpent,
    Expression<String>? contentProgress,
    Expression<int>? streakDays,
    Expression<int>? attempts,
    Expression<bool>? bookmarked,
    Expression<String>? notes,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lessonId != null) 'lesson_id': lessonId,
      if (userId != null) 'user_id': userId,
      if (startedAt != null) 'started_at': startedAt,
      if (lastAccessed != null) 'last_accessed': lastAccessed,
      if (completedAt != null) 'completed_at': completedAt,
      if (completionStatus != null) 'completion_status': completionStatus,
      if (overallScore != null) 'overall_score': overallScore,
      if (totalTimeSpent != null) 'total_time_spent': totalTimeSpent,
      if (contentProgress != null) 'content_progress': contentProgress,
      if (streakDays != null) 'streak_days': streakDays,
      if (attempts != null) 'attempts': attempts,
      if (bookmarked != null) 'bookmarked': bookmarked,
      if (notes != null) 'notes': notes,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LessonProgressCompanion copyWith(
      {Value<String>? lessonId,
      Value<String>? userId,
      Value<DateTime?>? startedAt,
      Value<DateTime?>? lastAccessed,
      Value<DateTime?>? completedAt,
      Value<String>? completionStatus,
      Value<double?>? overallScore,
      Value<int>? totalTimeSpent,
      Value<String>? contentProgress,
      Value<int>? streakDays,
      Value<int>? attempts,
      Value<bool>? bookmarked,
      Value<String?>? notes,
      Value<String>? metadata,
      Value<int>? rowid}) {
    return LessonProgressCompanion(
      lessonId: lessonId ?? this.lessonId,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      completedAt: completedAt ?? this.completedAt,
      completionStatus: completionStatus ?? this.completionStatus,
      overallScore: overallScore ?? this.overallScore,
      totalTimeSpent: totalTimeSpent ?? this.totalTimeSpent,
      contentProgress: contentProgress ?? this.contentProgress,
      streakDays: streakDays ?? this.streakDays,
      attempts: attempts ?? this.attempts,
      bookmarked: bookmarked ?? this.bookmarked,
      notes: notes ?? this.notes,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (lastAccessed.present) {
      map['last_accessed'] = Variable<DateTime>(lastAccessed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (completionStatus.present) {
      map['completion_status'] = Variable<String>(completionStatus.value);
    }
    if (overallScore.present) {
      map['overall_score'] = Variable<double>(overallScore.value);
    }
    if (totalTimeSpent.present) {
      map['total_time_spent'] = Variable<int>(totalTimeSpent.value);
    }
    if (contentProgress.present) {
      map['content_progress'] = Variable<String>(contentProgress.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (bookmarked.present) {
      map['bookmarked'] = Variable<bool>(bookmarked.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonProgressCompanion(')
          ..write('lessonId: $lessonId, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('lastAccessed: $lastAccessed, ')
          ..write('completedAt: $completedAt, ')
          ..write('completionStatus: $completionStatus, ')
          ..write('overallScore: $overallScore, ')
          ..write('totalTimeSpent: $totalTimeSpent, ')
          ..write('contentProgress: $contentProgress, ')
          ..write('streakDays: $streakDays, ')
          ..write('attempts: $attempts, ')
          ..write('bookmarked: $bookmarked, ')
          ..write('notes: $notes, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconUrlMeta =
      const VerificationMeta('iconUrl');
  @override
  late final GeneratedColumn<String> iconUrl = GeneratedColumn<String>(
      'icon_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lessonCountMeta =
      const VerificationMeta('lessonCount');
  @override
  late final GeneratedColumn<int> lessonCount = GeneratedColumn<int>(
      'lesson_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalDurationMeta =
      const VerificationMeta('totalDuration');
  @override
  late final GeneratedColumn<int> totalDuration = GeneratedColumn<int>(
      'total_duration', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _levelsMeta = const VerificationMeta('levels');
  @override
  late final GeneratedColumn<String> levels = GeneratedColumn<String>(
      'levels', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
      'difficulty', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _featuredMeta =
      const VerificationMeta('featured');
  @override
  late final GeneratedColumn<bool> featured = GeneratedColumn<bool>(
      'featured', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("featured" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        iconUrl,
        imageUrl,
        color,
        lessonCount,
        totalDuration,
        levels,
        difficulty,
        isActive,
        sortOrder,
        featured,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon_url')) {
      context.handle(_iconUrlMeta,
          iconUrl.isAcceptableOrUnknown(data['icon_url']!, _iconUrlMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('lesson_count')) {
      context.handle(
          _lessonCountMeta,
          lessonCount.isAcceptableOrUnknown(
              data['lesson_count']!, _lessonCountMeta));
    }
    if (data.containsKey('total_duration')) {
      context.handle(
          _totalDurationMeta,
          totalDuration.isAcceptableOrUnknown(
              data['total_duration']!, _totalDurationMeta));
    }
    if (data.containsKey('levels')) {
      context.handle(_levelsMeta,
          levels.isAcceptableOrUnknown(data['levels']!, _levelsMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('featured')) {
      context.handle(_featuredMeta,
          featured.isAcceptableOrUnknown(data['featured']!, _featuredMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      iconUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_url']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      lessonCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lesson_count'])!,
      totalDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_duration'])!,
      levels: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}levels'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difficulty']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      featured: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}featured'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final String description;
  final String? iconUrl;
  final String? imageUrl;
  final String? color;
  final int lessonCount;
  final int totalDuration;
  final String levels;
  final double? difficulty;
  final bool isActive;
  final int sortOrder;
  final bool featured;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Category(
      {required this.id,
      required this.name,
      required this.description,
      this.iconUrl,
      this.imageUrl,
      this.color,
      required this.lessonCount,
      required this.totalDuration,
      required this.levels,
      this.difficulty,
      required this.isActive,
      required this.sortOrder,
      required this.featured,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || iconUrl != null) {
      map['icon_url'] = Variable<String>(iconUrl);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['lesson_count'] = Variable<int>(lessonCount);
    map['total_duration'] = Variable<int>(totalDuration);
    map['levels'] = Variable<String>(levels);
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<double>(difficulty);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    map['featured'] = Variable<bool>(featured);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      iconUrl: iconUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(iconUrl),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      lessonCount: Value(lessonCount),
      totalDuration: Value(totalDuration),
      levels: Value(levels),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
      featured: Value(featured),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      iconUrl: serializer.fromJson<String?>(json['iconUrl']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      color: serializer.fromJson<String?>(json['color']),
      lessonCount: serializer.fromJson<int>(json['lessonCount']),
      totalDuration: serializer.fromJson<int>(json['totalDuration']),
      levels: serializer.fromJson<String>(json['levels']),
      difficulty: serializer.fromJson<double?>(json['difficulty']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      featured: serializer.fromJson<bool>(json['featured']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'iconUrl': serializer.toJson<String?>(iconUrl),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'color': serializer.toJson<String?>(color),
      'lessonCount': serializer.toJson<int>(lessonCount),
      'totalDuration': serializer.toJson<int>(totalDuration),
      'levels': serializer.toJson<String>(levels),
      'difficulty': serializer.toJson<double?>(difficulty),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'featured': serializer.toJson<bool>(featured),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Category copyWith(
          {String? id,
          String? name,
          String? description,
          Value<String?> iconUrl = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> color = const Value.absent(),
          int? lessonCount,
          int? totalDuration,
          String? levels,
          Value<double?> difficulty = const Value.absent(),
          bool? isActive,
          int? sortOrder,
          bool? featured,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        iconUrl: iconUrl.present ? iconUrl.value : this.iconUrl,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        color: color.present ? color.value : this.color,
        lessonCount: lessonCount ?? this.lessonCount,
        totalDuration: totalDuration ?? this.totalDuration,
        levels: levels ?? this.levels,
        difficulty: difficulty.present ? difficulty.value : this.difficulty,
        isActive: isActive ?? this.isActive,
        sortOrder: sortOrder ?? this.sortOrder,
        featured: featured ?? this.featured,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      iconUrl: data.iconUrl.present ? data.iconUrl.value : this.iconUrl,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      color: data.color.present ? data.color.value : this.color,
      lessonCount:
          data.lessonCount.present ? data.lessonCount.value : this.lessonCount,
      totalDuration: data.totalDuration.present
          ? data.totalDuration.value
          : this.totalDuration,
      levels: data.levels.present ? data.levels.value : this.levels,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      featured: data.featured.present ? data.featured.value : this.featured,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('color: $color, ')
          ..write('lessonCount: $lessonCount, ')
          ..write('totalDuration: $totalDuration, ')
          ..write('levels: $levels, ')
          ..write('difficulty: $difficulty, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('featured: $featured, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      description,
      iconUrl,
      imageUrl,
      color,
      lessonCount,
      totalDuration,
      levels,
      difficulty,
      isActive,
      sortOrder,
      featured,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.iconUrl == this.iconUrl &&
          other.imageUrl == this.imageUrl &&
          other.color == this.color &&
          other.lessonCount == this.lessonCount &&
          other.totalDuration == this.totalDuration &&
          other.levels == this.levels &&
          other.difficulty == this.difficulty &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder &&
          other.featured == this.featured &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> iconUrl;
  final Value<String?> imageUrl;
  final Value<String?> color;
  final Value<int> lessonCount;
  final Value<int> totalDuration;
  final Value<String> levels;
  final Value<double?> difficulty;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  final Value<bool> featured;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.color = const Value.absent(),
    this.lessonCount = const Value.absent(),
    this.totalDuration = const Value.absent(),
    this.levels = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.featured = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String description,
    this.iconUrl = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.color = const Value.absent(),
    this.lessonCount = const Value.absent(),
    this.totalDuration = const Value.absent(),
    this.levels = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.featured = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        description = Value(description);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? iconUrl,
    Expression<String>? imageUrl,
    Expression<String>? color,
    Expression<int>? lessonCount,
    Expression<int>? totalDuration,
    Expression<String>? levels,
    Expression<double>? difficulty,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
    Expression<bool>? featured,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (iconUrl != null) 'icon_url': iconUrl,
      if (imageUrl != null) 'image_url': imageUrl,
      if (color != null) 'color': color,
      if (lessonCount != null) 'lesson_count': lessonCount,
      if (totalDuration != null) 'total_duration': totalDuration,
      if (levels != null) 'levels': levels,
      if (difficulty != null) 'difficulty': difficulty,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (featured != null) 'featured': featured,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String?>? iconUrl,
      Value<String?>? imageUrl,
      Value<String?>? color,
      Value<int>? lessonCount,
      Value<int>? totalDuration,
      Value<String>? levels,
      Value<double?>? difficulty,
      Value<bool>? isActive,
      Value<int>? sortOrder,
      Value<bool>? featured,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
      lessonCount: lessonCount ?? this.lessonCount,
      totalDuration: totalDuration ?? this.totalDuration,
      levels: levels ?? this.levels,
      difficulty: difficulty ?? this.difficulty,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      featured: featured ?? this.featured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconUrl.present) {
      map['icon_url'] = Variable<String>(iconUrl.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (lessonCount.present) {
      map['lesson_count'] = Variable<int>(lessonCount.value);
    }
    if (totalDuration.present) {
      map['total_duration'] = Variable<int>(totalDuration.value);
    }
    if (levels.present) {
      map['levels'] = Variable<String>(levels.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (featured.present) {
      map['featured'] = Variable<bool>(featured.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('color: $color, ')
          ..write('lessonCount: $lessonCount, ')
          ..write('totalDuration: $totalDuration, ')
          ..write('levels: $levels, ')
          ..write('difficulty: $difficulty, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('featured: $featured, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LessonsTable lessons = $LessonsTable(this);
  late final $LessonContentTable lessonContent = $LessonContentTable(this);
  late final $LessonProgressTable lessonProgress = $LessonProgressTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [lessons, lessonContent, lessonProgress, categories];
}

typedef $$LessonsTableCreateCompanionBuilder = LessonsCompanion Function({
  required String id,
  required String title,
  required String description,
  required String level,
  required String category,
  required String type,
  required int duration,
  required double difficulty,
  Value<String?> imageUrl,
  Value<String?> audioUrl,
  Value<bool> isPremium,
  Value<bool> isCompleted,
  Value<double> progress,
  Value<bool> bookmarked,
  Value<double> rating,
  Value<int> totalRatings,
  Value<String> tags,
  Value<String> prerequisites,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> lastAccessed,
  Value<int> rowid,
});
typedef $$LessonsTableUpdateCompanionBuilder = LessonsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> description,
  Value<String> level,
  Value<String> category,
  Value<String> type,
  Value<int> duration,
  Value<double> difficulty,
  Value<String?> imageUrl,
  Value<String?> audioUrl,
  Value<bool> isPremium,
  Value<bool> isCompleted,
  Value<double> progress,
  Value<bool> bookmarked,
  Value<double> rating,
  Value<int> totalRatings,
  Value<String> tags,
  Value<String> prerequisites,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<DateTime?> lastAccessed,
  Value<int> rowid,
});

class $$LessonsTableFilterComposer
    extends Composer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioUrl => $composableBuilder(
      column: $table.audioUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPremium => $composableBuilder(
      column: $table.isPremium, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get bookmarked => $composableBuilder(
      column: $table.bookmarked, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalRatings => $composableBuilder(
      column: $table.totalRatings, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prerequisites => $composableBuilder(
      column: $table.prerequisites, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAccessed => $composableBuilder(
      column: $table.lastAccessed, builder: (column) => ColumnFilters(column));
}

class $$LessonsTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioUrl => $composableBuilder(
      column: $table.audioUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPremium => $composableBuilder(
      column: $table.isPremium, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get bookmarked => $composableBuilder(
      column: $table.bookmarked, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalRatings => $composableBuilder(
      column: $table.totalRatings,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prerequisites => $composableBuilder(
      column: $table.prerequisites,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAccessed => $composableBuilder(
      column: $table.lastAccessed,
      builder: (column) => ColumnOrderings(column));
}

class $$LessonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonsTable> {
  $$LessonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<bool> get isPremium =>
      $composableBuilder(column: $table.isPremium, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<bool> get bookmarked => $composableBuilder(
      column: $table.bookmarked, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get totalRatings => $composableBuilder(
      column: $table.totalRatings, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get prerequisites => $composableBuilder(
      column: $table.prerequisites, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAccessed => $composableBuilder(
      column: $table.lastAccessed, builder: (column) => column);
}

class $$LessonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LessonsTable,
    Lesson,
    $$LessonsTableFilterComposer,
    $$LessonsTableOrderingComposer,
    $$LessonsTableAnnotationComposer,
    $$LessonsTableCreateCompanionBuilder,
    $$LessonsTableUpdateCompanionBuilder,
    (Lesson, BaseReferences<_$AppDatabase, $LessonsTable, Lesson>),
    Lesson,
    PrefetchHooks Function()> {
  $$LessonsTableTableManager(_$AppDatabase db, $LessonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> level = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<double> difficulty = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> audioUrl = const Value.absent(),
            Value<bool> isPremium = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<bool> bookmarked = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<int> totalRatings = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<String> prerequisites = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> lastAccessed = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonsCompanion(
            id: id,
            title: title,
            description: description,
            level: level,
            category: category,
            type: type,
            duration: duration,
            difficulty: difficulty,
            imageUrl: imageUrl,
            audioUrl: audioUrl,
            isPremium: isPremium,
            isCompleted: isCompleted,
            progress: progress,
            bookmarked: bookmarked,
            rating: rating,
            totalRatings: totalRatings,
            tags: tags,
            prerequisites: prerequisites,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastAccessed: lastAccessed,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String description,
            required String level,
            required String category,
            required String type,
            required int duration,
            required double difficulty,
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> audioUrl = const Value.absent(),
            Value<bool> isPremium = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<bool> bookmarked = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<int> totalRatings = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<String> prerequisites = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<DateTime?> lastAccessed = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonsCompanion.insert(
            id: id,
            title: title,
            description: description,
            level: level,
            category: category,
            type: type,
            duration: duration,
            difficulty: difficulty,
            imageUrl: imageUrl,
            audioUrl: audioUrl,
            isPremium: isPremium,
            isCompleted: isCompleted,
            progress: progress,
            bookmarked: bookmarked,
            rating: rating,
            totalRatings: totalRatings,
            tags: tags,
            prerequisites: prerequisites,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastAccessed: lastAccessed,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LessonsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LessonsTable,
    Lesson,
    $$LessonsTableFilterComposer,
    $$LessonsTableOrderingComposer,
    $$LessonsTableAnnotationComposer,
    $$LessonsTableCreateCompanionBuilder,
    $$LessonsTableUpdateCompanionBuilder,
    (Lesson, BaseReferences<_$AppDatabase, $LessonsTable, Lesson>),
    Lesson,
    PrefetchHooks Function()>;
typedef $$LessonContentTableCreateCompanionBuilder = LessonContentCompanion
    Function({
  required String id,
  required String lessonId,
  required String title,
  required String contentType,
  required int order,
  Value<String?> textContent,
  Value<String?> audioUrl,
  Value<String?> imageUrl,
  Value<String?> videoUrl,
  Value<String?> interactiveData,
  Value<int?> duration,
  Value<String?> phoneticTranscription,
  Value<String?> translation,
  Value<double?> difficulty,
  Value<bool> isCompleted,
  Value<double?> userScore,
  Value<String> metadata,
  Value<int> rowid,
});
typedef $$LessonContentTableUpdateCompanionBuilder = LessonContentCompanion
    Function({
  Value<String> id,
  Value<String> lessonId,
  Value<String> title,
  Value<String> contentType,
  Value<int> order,
  Value<String?> textContent,
  Value<String?> audioUrl,
  Value<String?> imageUrl,
  Value<String?> videoUrl,
  Value<String?> interactiveData,
  Value<int?> duration,
  Value<String?> phoneticTranscription,
  Value<String?> translation,
  Value<double?> difficulty,
  Value<bool> isCompleted,
  Value<double?> userScore,
  Value<String> metadata,
  Value<int> rowid,
});

class $$LessonContentTableFilterComposer
    extends Composer<_$AppDatabase, $LessonContentTable> {
  $$LessonContentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textContent => $composableBuilder(
      column: $table.textContent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioUrl => $composableBuilder(
      column: $table.audioUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get videoUrl => $composableBuilder(
      column: $table.videoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get interactiveData => $composableBuilder(
      column: $table.interactiveData,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneticTranscription => $composableBuilder(
      column: $table.phoneticTranscription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get translation => $composableBuilder(
      column: $table.translation, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get userScore => $composableBuilder(
      column: $table.userScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));
}

class $$LessonContentTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonContentTable> {
  $$LessonContentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textContent => $composableBuilder(
      column: $table.textContent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioUrl => $composableBuilder(
      column: $table.audioUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get videoUrl => $composableBuilder(
      column: $table.videoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get interactiveData => $composableBuilder(
      column: $table.interactiveData,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneticTranscription => $composableBuilder(
      column: $table.phoneticTranscription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translation => $composableBuilder(
      column: $table.translation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get userScore => $composableBuilder(
      column: $table.userScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));
}

class $$LessonContentTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonContentTable> {
  $$LessonContentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
      column: $table.textContent, builder: (column) => column);

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get videoUrl =>
      $composableBuilder(column: $table.videoUrl, builder: (column) => column);

  GeneratedColumn<String> get interactiveData => $composableBuilder(
      column: $table.interactiveData, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get phoneticTranscription => $composableBuilder(
      column: $table.phoneticTranscription, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
      column: $table.translation, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<double> get userScore =>
      $composableBuilder(column: $table.userScore, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$LessonContentTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LessonContentTable,
    LessonContentData,
    $$LessonContentTableFilterComposer,
    $$LessonContentTableOrderingComposer,
    $$LessonContentTableAnnotationComposer,
    $$LessonContentTableCreateCompanionBuilder,
    $$LessonContentTableUpdateCompanionBuilder,
    (
      LessonContentData,
      BaseReferences<_$AppDatabase, $LessonContentTable, LessonContentData>
    ),
    LessonContentData,
    PrefetchHooks Function()> {
  $$LessonContentTableTableManager(_$AppDatabase db, $LessonContentTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonContentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonContentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonContentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> lessonId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> contentType = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<String?> textContent = const Value.absent(),
            Value<String?> audioUrl = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> videoUrl = const Value.absent(),
            Value<String?> interactiveData = const Value.absent(),
            Value<int?> duration = const Value.absent(),
            Value<String?> phoneticTranscription = const Value.absent(),
            Value<String?> translation = const Value.absent(),
            Value<double?> difficulty = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<double?> userScore = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonContentCompanion(
            id: id,
            lessonId: lessonId,
            title: title,
            contentType: contentType,
            order: order,
            textContent: textContent,
            audioUrl: audioUrl,
            imageUrl: imageUrl,
            videoUrl: videoUrl,
            interactiveData: interactiveData,
            duration: duration,
            phoneticTranscription: phoneticTranscription,
            translation: translation,
            difficulty: difficulty,
            isCompleted: isCompleted,
            userScore: userScore,
            metadata: metadata,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String lessonId,
            required String title,
            required String contentType,
            required int order,
            Value<String?> textContent = const Value.absent(),
            Value<String?> audioUrl = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> videoUrl = const Value.absent(),
            Value<String?> interactiveData = const Value.absent(),
            Value<int?> duration = const Value.absent(),
            Value<String?> phoneticTranscription = const Value.absent(),
            Value<String?> translation = const Value.absent(),
            Value<double?> difficulty = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<double?> userScore = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonContentCompanion.insert(
            id: id,
            lessonId: lessonId,
            title: title,
            contentType: contentType,
            order: order,
            textContent: textContent,
            audioUrl: audioUrl,
            imageUrl: imageUrl,
            videoUrl: videoUrl,
            interactiveData: interactiveData,
            duration: duration,
            phoneticTranscription: phoneticTranscription,
            translation: translation,
            difficulty: difficulty,
            isCompleted: isCompleted,
            userScore: userScore,
            metadata: metadata,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LessonContentTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LessonContentTable,
    LessonContentData,
    $$LessonContentTableFilterComposer,
    $$LessonContentTableOrderingComposer,
    $$LessonContentTableAnnotationComposer,
    $$LessonContentTableCreateCompanionBuilder,
    $$LessonContentTableUpdateCompanionBuilder,
    (
      LessonContentData,
      BaseReferences<_$AppDatabase, $LessonContentTable, LessonContentData>
    ),
    LessonContentData,
    PrefetchHooks Function()>;
typedef $$LessonProgressTableCreateCompanionBuilder = LessonProgressCompanion
    Function({
  required String lessonId,
  required String userId,
  Value<DateTime?> startedAt,
  Value<DateTime?> lastAccessed,
  Value<DateTime?> completedAt,
  Value<String> completionStatus,
  Value<double?> overallScore,
  Value<int> totalTimeSpent,
  Value<String> contentProgress,
  Value<int> streakDays,
  Value<int> attempts,
  Value<bool> bookmarked,
  Value<String?> notes,
  Value<String> metadata,
  Value<int> rowid,
});
typedef $$LessonProgressTableUpdateCompanionBuilder = LessonProgressCompanion
    Function({
  Value<String> lessonId,
  Value<String> userId,
  Value<DateTime?> startedAt,
  Value<DateTime?> lastAccessed,
  Value<DateTime?> completedAt,
  Value<String> completionStatus,
  Value<double?> overallScore,
  Value<int> totalTimeSpent,
  Value<String> contentProgress,
  Value<int> streakDays,
  Value<int> attempts,
  Value<bool> bookmarked,
  Value<String?> notes,
  Value<String> metadata,
  Value<int> rowid,
});

class $$LessonProgressTableFilterComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAccessed => $composableBuilder(
      column: $table.lastAccessed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get completionStatus => $composableBuilder(
      column: $table.completionStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get overallScore => $composableBuilder(
      column: $table.overallScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalTimeSpent => $composableBuilder(
      column: $table.totalTimeSpent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentProgress => $composableBuilder(
      column: $table.contentProgress,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get bookmarked => $composableBuilder(
      column: $table.bookmarked, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));
}

class $$LessonProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get lessonId => $composableBuilder(
      column: $table.lessonId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAccessed => $composableBuilder(
      column: $table.lastAccessed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get completionStatus => $composableBuilder(
      column: $table.completionStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get overallScore => $composableBuilder(
      column: $table.overallScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalTimeSpent => $composableBuilder(
      column: $table.totalTimeSpent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentProgress => $composableBuilder(
      column: $table.contentProgress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts => $composableBuilder(
      column: $table.attempts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get bookmarked => $composableBuilder(
      column: $table.bookmarked, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));
}

class $$LessonProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonProgressTable> {
  $$LessonProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAccessed => $composableBuilder(
      column: $table.lastAccessed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<String> get completionStatus => $composableBuilder(
      column: $table.completionStatus, builder: (column) => column);

  GeneratedColumn<double> get overallScore => $composableBuilder(
      column: $table.overallScore, builder: (column) => column);

  GeneratedColumn<int> get totalTimeSpent => $composableBuilder(
      column: $table.totalTimeSpent, builder: (column) => column);

  GeneratedColumn<String> get contentProgress => $composableBuilder(
      column: $table.contentProgress, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<bool> get bookmarked => $composableBuilder(
      column: $table.bookmarked, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$LessonProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LessonProgressTable,
    LessonProgressData,
    $$LessonProgressTableFilterComposer,
    $$LessonProgressTableOrderingComposer,
    $$LessonProgressTableAnnotationComposer,
    $$LessonProgressTableCreateCompanionBuilder,
    $$LessonProgressTableUpdateCompanionBuilder,
    (
      LessonProgressData,
      BaseReferences<_$AppDatabase, $LessonProgressTable, LessonProgressData>
    ),
    LessonProgressData,
    PrefetchHooks Function()> {
  $$LessonProgressTableTableManager(
      _$AppDatabase db, $LessonProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> lessonId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> lastAccessed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<String> completionStatus = const Value.absent(),
            Value<double?> overallScore = const Value.absent(),
            Value<int> totalTimeSpent = const Value.absent(),
            Value<String> contentProgress = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<bool> bookmarked = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonProgressCompanion(
            lessonId: lessonId,
            userId: userId,
            startedAt: startedAt,
            lastAccessed: lastAccessed,
            completedAt: completedAt,
            completionStatus: completionStatus,
            overallScore: overallScore,
            totalTimeSpent: totalTimeSpent,
            contentProgress: contentProgress,
            streakDays: streakDays,
            attempts: attempts,
            bookmarked: bookmarked,
            notes: notes,
            metadata: metadata,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String lessonId,
            required String userId,
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> lastAccessed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<String> completionStatus = const Value.absent(),
            Value<double?> overallScore = const Value.absent(),
            Value<int> totalTimeSpent = const Value.absent(),
            Value<String> contentProgress = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<int> attempts = const Value.absent(),
            Value<bool> bookmarked = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LessonProgressCompanion.insert(
            lessonId: lessonId,
            userId: userId,
            startedAt: startedAt,
            lastAccessed: lastAccessed,
            completedAt: completedAt,
            completionStatus: completionStatus,
            overallScore: overallScore,
            totalTimeSpent: totalTimeSpent,
            contentProgress: contentProgress,
            streakDays: streakDays,
            attempts: attempts,
            bookmarked: bookmarked,
            notes: notes,
            metadata: metadata,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LessonProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LessonProgressTable,
    LessonProgressData,
    $$LessonProgressTableFilterComposer,
    $$LessonProgressTableOrderingComposer,
    $$LessonProgressTableAnnotationComposer,
    $$LessonProgressTableCreateCompanionBuilder,
    $$LessonProgressTableUpdateCompanionBuilder,
    (
      LessonProgressData,
      BaseReferences<_$AppDatabase, $LessonProgressTable, LessonProgressData>
    ),
    LessonProgressData,
    PrefetchHooks Function()>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  required String description,
  Value<String?> iconUrl,
  Value<String?> imageUrl,
  Value<String?> color,
  Value<int> lessonCount,
  Value<int> totalDuration,
  Value<String> levels,
  Value<double?> difficulty,
  Value<bool> isActive,
  Value<int> sortOrder,
  Value<bool> featured,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> description,
  Value<String?> iconUrl,
  Value<String?> imageUrl,
  Value<String?> color,
  Value<int> lessonCount,
  Value<int> totalDuration,
  Value<String> levels,
  Value<double?> difficulty,
  Value<bool> isActive,
  Value<int> sortOrder,
  Value<bool> featured,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconUrl => $composableBuilder(
      column: $table.iconUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lessonCount => $composableBuilder(
      column: $table.lessonCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalDuration => $composableBuilder(
      column: $table.totalDuration, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get levels => $composableBuilder(
      column: $table.levels, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get featured => $composableBuilder(
      column: $table.featured, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconUrl => $composableBuilder(
      column: $table.iconUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lessonCount => $composableBuilder(
      column: $table.lessonCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalDuration => $composableBuilder(
      column: $table.totalDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get levels => $composableBuilder(
      column: $table.levels, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get featured => $composableBuilder(
      column: $table.featured, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get iconUrl =>
      $composableBuilder(column: $table.iconUrl, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get lessonCount => $composableBuilder(
      column: $table.lessonCount, builder: (column) => column);

  GeneratedColumn<int> get totalDuration => $composableBuilder(
      column: $table.totalDuration, builder: (column) => column);

  GeneratedColumn<String> get levels =>
      $composableBuilder(column: $table.levels, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get featured =>
      $composableBuilder(column: $table.featured, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
    Category,
    PrefetchHooks Function()> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> iconUrl = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int> lessonCount = const Value.absent(),
            Value<int> totalDuration = const Value.absent(),
            Value<String> levels = const Value.absent(),
            Value<double?> difficulty = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> featured = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
            description: description,
            iconUrl: iconUrl,
            imageUrl: imageUrl,
            color: color,
            lessonCount: lessonCount,
            totalDuration: totalDuration,
            levels: levels,
            difficulty: difficulty,
            isActive: isActive,
            sortOrder: sortOrder,
            featured: featured,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String description,
            Value<String?> iconUrl = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int> lessonCount = const Value.absent(),
            Value<int> totalDuration = const Value.absent(),
            Value<String> levels = const Value.absent(),
            Value<double?> difficulty = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> featured = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
            description: description,
            iconUrl: iconUrl,
            imageUrl: imageUrl,
            color: color,
            lessonCount: lessonCount,
            totalDuration: totalDuration,
            levels: levels,
            difficulty: difficulty,
            isActive: isActive,
            sortOrder: sortOrder,
            featured: featured,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
    Category,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LessonsTableTableManager get lessons =>
      $$LessonsTableTableManager(_db, _db.lessons);
  $$LessonContentTableTableManager get lessonContent =>
      $$LessonContentTableTableManager(_db, _db.lessonContent);
  $$LessonProgressTableTableManager get lessonProgress =>
      $$LessonProgressTableTableManager(_db, _db.lessonProgress);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
}
