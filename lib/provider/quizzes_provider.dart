import 'dart:convert';

import 'package:basicprog/model/question.dart';
import 'package:basicprog/model/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizzesProvider with ChangeNotifier {
  List<Quiz> quizzes;

  QuizzesProvider() : quizzes = [] {
    initialize();
  }

  void initialize() {
    parseQuizzesFromJsonFile().then((parsedQuizzes) {
      quizzes = parsedQuizzes;
      notifyListeners(); // Notify any listeners that the quizzes have been updated.
    });
  }

  Future<List<Quiz>> parseQuizzesFromJsonFile() async {
    // Read the JSON file into a String
    final jsonString = await rootBundle.loadString('assets/exercises.json');

    // Parse the JSON data
    final jsonData = json.decode(jsonString);

    // Extract and parse quizzes
    final exercisesData = jsonData['exercises'] as List<dynamic>;
    final quizzes = exercisesData.map((exerciseData) {
      final exerciseTitle = exerciseData['exercise'] as String;
      final questionsData = exerciseData['questions'] as List<dynamic>;
      final questions = questionsData.map((questionData) {
        final questionText = questionData['question'] as String;
        final optionsData = questionData['options'] as List<dynamic>;
        final options = optionsData.map((option) => option as String).toList();
        final correctAnswerIndex = questionData['answer'] as int;

        return Question(
          question: questionText,
          choices: options,
          correctAnswerIndex: correctAnswerIndex,
        );
      }).toList();

      return Quiz(
        title: exerciseTitle,
        description: '', // You can add a description if available in the JSON.
        questions: questions,
      );
    }).toList();

    return quizzes;
  }
}
