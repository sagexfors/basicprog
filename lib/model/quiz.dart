import 'dart:math';

import 'package:basicprog/model/question.dart';

class Quiz {
  final int id;
  String title;
  String description;
  List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final title = json['title'] as String;
    final description = json['description'] ?? '';
    final questionsData = json['questions'] as List<dynamic>;

    // Shuffle the questionsData list
    final random = Random();
    questionsData.shuffle(random);

    final questions = questionsData.map((questionData) {
      final questionText = questionData['question'] as String;
      final optionsData = questionData['options'] as List<dynamic>;
      final options = optionsData.map((option) => option as String).toList();
      final correctAnswerIndex = questionData['answer'] as int;

      return Question(
        id: questionData['id'] ?? 0,
        question: questionText,
        choices: options,
        correctAnswerIndex: correctAnswerIndex,
      );
    }).toList();

    return Quiz(
      id: id,
      title: title,
      description: description,
      questions: questions,
    );
  }
}
