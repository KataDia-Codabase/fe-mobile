enum ReadingStatus { completed, inProgress, available }

class ReadingLesson {
  final String title;
  final String description;
  final String level;
  final String duration;
  final int articles;
  final int xpReward;
  final double progress;
  final ReadingStatus status;
  final int completedPassages;
  final int totalPassages;
  final List<ReadingPassage> passages;

  const ReadingLesson({
    required this.title,
    required this.description,
    required this.level,
    required this.duration,
    required this.articles,
    required this.xpReward,
    required this.progress,
    required this.status,
    required this.completedPassages,
    required this.totalPassages,
    this.passages = const [],
  });
}

class ReadingPassage {
  final int order;
  final String title;
  final String durationLabel;
  final int questions;
  final bool completed;
  final List<String> paragraphs;

  const ReadingPassage({
    required this.order,
    required this.title,
    required this.durationLabel,
    required this.questions,
    required this.completed,
    required this.paragraphs,
  });
}
