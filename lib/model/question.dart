class Question {
  final int id;
  final String question;
  final List<String> choices;
  final int correctAnswerIndex;

  Question({
    required this.id,
    required this.question,
    required this.choices,
    required this.correctAnswerIndex,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final questionText = json['question'] as String;
    final optionsData = json['options'] as List<dynamic>;
    final options = optionsData.map((option) => option as String).toList();
    final correctAnswerIndex = json['answer'] as int;

    return Question(
      id: json['id'] as int,
      question: questionText,
      choices: options,
      correctAnswerIndex: correctAnswerIndex,
    );
  }
}
