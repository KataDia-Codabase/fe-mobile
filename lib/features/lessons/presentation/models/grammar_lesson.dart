enum GrammarStatus { completed, inProgress, available }

class GrammarLesson {
  final String title;
  final String description;
  final String level;
  final String duration;
  final int questionsCount;
  final GrammarStatus status;
  final double progress;
  final int setsCount;
  final int completedSets;
  final List<GrammarExerciseSet> exerciseSets;
  final GrammarLessonInfo info;
  final List<GrammarQuestion> questions;

  const GrammarLesson({
    required this.title,
    required this.description,
    required this.level,
    required this.duration,
    required this.questionsCount,
    required this.status,
    required this.progress,
    required this.setsCount,
    required this.completedSets,
    required this.exerciseSets,
    required this.info,
    required this.questions,
  });
}

class GrammarExerciseSet {
  final String title;
  final String duration;
  final int exercises;
  final String description;
  final bool completed;

  const GrammarExerciseSet({
    required this.title,
    required this.duration,
    required this.exercises,
    required this.description,
    required this.completed,
  });
}

class GrammarLessonInfo {
  final String about;
  final String ruleTitle;
  final String ruleDescription;
  final List<String> examples;

  const GrammarLessonInfo({
    required this.about,
    required this.ruleTitle,
    required this.ruleDescription,
    required this.examples,
  });
}

class GrammarQuestion {
  final String prompt;
  final List<String> options;
  final int answerIndex;

  const GrammarQuestion({
    required this.prompt,
    required this.options,
    required this.answerIndex,
  });
}
