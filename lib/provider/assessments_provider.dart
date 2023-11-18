import 'dart:convert';

import 'package:basicprog/model/question.dart';
import 'package:basicprog/model/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssessmentsProvider with ChangeNotifier {
  List<Quiz> assessments;

  AssessmentsProvider() : assessments = [] {
    initialize();
  }

  void initialize() {
    parseAssessmentsFromJsonFile().then((parsedAssessments) {
      assessments = parsedAssessments;
      notifyListeners(); // Notify any listeners that the assessments have been updated.
    });
  }

  Future<List<Quiz>> parseAssessmentsFromJsonFile() async {
    // Read the JSON file into a String
    final jsonString = await rootBundle.loadString('assets/questions.json');

    // Parse the JSON data
    final jsonData = json.decode(jsonString);

    // Extract and parse questions
    final questionsData = jsonData['questions'] as List<dynamic>;

    // Create a list to hold the assessments
    final List<Quiz> assessments = [];

    // Loop to create 5 assessments
    for (int assessmentIndex = 1; assessmentIndex <= 5; assessmentIndex++) {
      // Shuffle the questions randomly for this assessment
      questionsData.shuffle();

      // Take the first 20 questions for the assessment
      final assessmentQuestionsData = questionsData.take(20).toList();

      final assessmentQuestions = assessmentQuestionsData.map((questionData) {
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

      // Create an Assessment quiz and add it to the list
      final assessment = Quiz(
        title: 'Assessment $assessmentIndex',
        description: 'This is a 20-question assessment.',
        questions: assessmentQuestions,
      );

      assessments.add(assessment);
    }

    // Return the list of assessments
    return assessments;
  }
}
