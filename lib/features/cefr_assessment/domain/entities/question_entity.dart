class Question {
  final String id;
  final String question;
  final String description;
  final String category; // Reading, Listening, etc
  final String correctAnswer;
  final List<String> options;
  final String cefrlevel; // A1, A2, B1, B2, C1, C2

  const Question({
    required this.id,
    required this.question,
    required this.description,
    required this.category,
    required this.correctAnswer,
    required this.options,
    required this.cefrlevel,
  });

  Question copyWith({
    String? id,
    String? question,
    String? description,
    String? category,
    String? correctAnswer,
    List<String>? options,
    String? cefrlevel,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      description: description ?? this.description,
      category: category ?? this.category,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      options: options ?? this.options,
      cefrlevel: cefrlevel ?? this.cefrlevel,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
