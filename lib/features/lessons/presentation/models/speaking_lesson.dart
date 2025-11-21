enum LessonStatus { completed, available }

class SpeakingLesson {
  final String title;
  final String level;
  final int sentences;
  final int xpReward;
  final double progress;
  final LessonStatus status;
  final String description;
  final int completedContents;
  final int totalContents;
  final List<LessonContent> contents;

  const SpeakingLesson({
    required this.title,
    required this.level,
    required this.sentences,
    required this.xpReward,
    required this.progress,
    required this.status,
    this.description = '',
    this.completedContents = 0,
    this.totalContents = 0,
    this.contents = const [],
  });
}

class LessonContent {
  final int order;
  final String phrase;
  final String translation;
  final String phonetic;
  final String tip;
  final double score;
  final bool completed;
  final String audioUrl;

  const LessonContent({
    required this.order,
    required this.phrase,
    required this.translation,
    required this.phonetic,
    required this.tip,
    this.score = 0,
    this.completed = false,
    this.audioUrl = '',
  });
}
