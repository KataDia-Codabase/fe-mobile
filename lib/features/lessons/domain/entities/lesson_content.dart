import 'package:equatable/equatable.dart';

enum ContentType {
  text('Text'),
  audio('Audio'),
  image('Image'),
  video('Video'),
  interactive('Interactive'),
  exercise('Exercise');

  const ContentType(this.displayName);
  
  final String displayName;
}

class LessonContent extends Equatable {
  const LessonContent({
    required this.id,
    required this.lessonId,
    required this.title,
    required this.contentType,
    required this.order,
    this.text,
    this.audioUrl,
    this.imageUrl,
    this.videoUrl,
    this.interactiveData,
    this.duration,
    this.phoneticTranscription,
    this.translation,
    this.difficulty,
    this.isCompleted = false,
    this.userScore,
    this.metadata = const {},
  });

  final String id;
  final String lessonId;
  final String title;
  final ContentType contentType;
  final int order;
  final String? text;
  final String? audioUrl;
  final String? imageUrl;
  final String? videoUrl;
  final Map<String, dynamic>? interactiveData;
  final int? duration; // in seconds for audio/video
  final String? phoneticTranscription;
  final String? translation;
  final double? difficulty; // 0.0 to 1.0
  final bool isCompleted;
  final double? userScore;
  final Map<String, dynamic> metadata;

  LessonContent copyWith({
    String? id,
    String? lessonId,
    String? title,
    ContentType? contentType,
    int? order,
    String? text,
    String? audioUrl,
    String? imageUrl,
    String? videoUrl,
    Map<String, dynamic>? interactiveData,
    int? duration,
    String? phoneticTranscription,
    String? translation,
    double? difficulty,
    bool? isCompleted,
    double? userScore,
    Map<String, dynamic>? metadata,
  }) {
    return LessonContent(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      title: title ?? this.title,
      contentType: contentType ?? this.contentType,
      order: order ?? this.order,
      text: text ?? this.text,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      interactiveData: interactiveData ?? this.interactiveData,
      duration: duration ?? this.duration,
      phoneticTranscription: phoneticTranscription ?? this.phoneticTranscription,
      translation: translation ?? this.translation,
      difficulty: difficulty ?? this.difficulty,
      isCompleted: isCompleted ?? this.isCompleted,
      userScore: userScore ?? this.userScore,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        lessonId,
        title,
        contentType,
        order,
        text,
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
        metadata,
      ];

  @override
  String toString() {
    return 'LessonContent(id: $id, title: $title, type: $contentType, order: $order)';
  }
}

class VocabularyWord extends Equatable {
  const VocabularyWord({
    required this.word,
    this.phoneticTranscription,
    this.audioUrl,
    this.translation,
    this.definition,
    this.example,
    this.partOfSpeech,
    this.difficulty,
    this.usageFrequency,
    this.synonyms = const [],
    this.antonyms = const [],
    this.context = const [],
  });

  final String word;
  final String? phoneticTranscription;
  final String? audioUrl;
  final String? translation;
  final String? definition;
  final String? example;
  final String? partOfSpeech;
  final double? difficulty;
  final double? usageFrequency; // 0.0 to 1.0
  final List<String> synonyms;
  final List<String> antonyms;
  final List<String> context;

  VocabularyWord copyWith({
    String? word,
    String? phoneticTranscription,
    String? audioUrl,
    String? translation,
    String? definition,
    String? example,
    String? partOfSpeech,
    double? difficulty,
    double? usageFrequency,
    List<String>? synonyms,
    List<String>? antonyms,
    List<String>? context,
  }) {
    return VocabularyWord(
      word: word ?? this.word,
      phoneticTranscription: phoneticTranscription ?? this.phoneticTranscription,
      audioUrl: audioUrl ?? this.audioUrl,
      translation: translation ?? this.translation,
      definition: definition ?? this.definition,
      example: example ?? this.example,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      difficulty: difficulty ?? this.difficulty,
      usageFrequency: usageFrequency ?? this.usageFrequency,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
      context: context ?? this.context,
    );
  }

  @override
  List<Object?> get props => [
        word,
        phoneticTranscription,
        audioUrl,
        translation,
        definition,
        example,
        partOfSpeech,
        difficulty,
        usageFrequency,
        synonyms,
        antonyms,
        context,
      ];

  @override
  String toString() {
    return 'VocabularyWord(word: $word, translation: $translation)';
  }
}

class PhraseExpression extends Equatable {
  const PhraseExpression({
    required this.phrase,
    this.phoneticTranscription,
    this.audioUrl,
    this.translation,
    this.meaning,
    this.usage,
    this.context,
    this.formality,
    this.variants = const [],
  });

  final String phrase;
  final String? phoneticTranscription;
  final String? audioUrl;
  final String? translation;
  final String? meaning;
  final String? usage;
  final String? context;
  final String? formality; // formal, informal, neutral
  final List<String> variants;

  PhraseExpression copyWith({
    String? phrase,
    String? phoneticTranscription,
    String? audioUrl,
    String? translation,
    String? meaning,
    String? usage,
    String? context,
    String? formality,
    List<String>? variants,
  }) {
    return PhraseExpression(
      phrase: phrase ?? this.phrase,
      phoneticTranscription: phoneticTranscription ?? this.phoneticTranscription,
      audioUrl: audioUrl ?? this.audioUrl,
      translation: translation ?? this.translation,
      meaning: meaning ?? this.meaning,
      usage: usage ?? this.usage,
      context: context ?? this.context,
      formality: formality ?? this.formality,
      variants: variants ?? this.variants,
    );
  }

  @override
  List<Object?> get props => [
        phrase,
        phoneticTranscription,
        audioUrl,
        translation,
        meaning,
        usage,
        context,
        formality,
        variants,
      ];

  @override
  String toString() {
    return 'PhraseExpression(phrase: $phrase, translation: $translation)';
  }
}
