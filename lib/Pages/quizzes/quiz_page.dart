import 'package:basicprog/fuzzy_logic.dart';
import 'package:basicprog/model/quiz.dart';
import 'package:basicprog/provider/quizzes_provider.dart';
import 'package:basicprog/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz;

  const QuizPage({Key? key, required this.quiz}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  List<Map<String, dynamic>> userResponses = [];

  Quiz get quiz => widget.quiz;

  void _handleAnswerSelected(int selectedChoiceIndex) {
    if (selectedChoiceIndex ==
        quiz.questions[currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        score++;
      });
    }

    userResponses.add({
      'response':
          quiz.questions[currentQuestionIndex].choices[selectedChoiceIndex],
    });

    if (currentQuestionIndex < quiz.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Quiz is completed, show the result

      Map<String, dynamic> result = quizPassFailAlgorithm(userResponses);
      final quizzesProvider = context.read<QuizzesProvider>();
      quizzesProvider.updateQuizScore(
        quiz.id.toString(),
        result['score'].toDouble(),
      );
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        FirestoreService().updateUserQuizScore(
          userId,
          quiz.id.toString(),
          result['score'].toDouble(),
        );
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Quiz Completed"),
            content: Text(
              "Your score: ${result['score']}\nResult: ${result['result']}",
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Map<String, dynamic> quizPassFailAlgorithm(
    List<Map<String, dynamic>> userResponses,
  ) {
    int correctResponses = 0;
    for (int i = 0; i < quiz.questions.length; i++) {
      if (userResponses[i]['response'].toLowerCase() ==
          quiz.questions[i].choices[quiz.questions[i].correctAnswerIndex]
              .toLowerCase()) {
        correctResponses++;
      }
    }
    double score = (correctResponses / quiz.questions.length) * 100;

    Map<String, double> fuzzyResult = fuzzyRuleEvaluation(score);
    double centroid = defuzzification(fuzzyResult);
    String result = (centroid >= 50) ? 'Pass' : 'Fail';

    return {
      'score': score,
      'fuzzyResult': fuzzyResult,
      'centroid': centroid,
      'result': result,
    };
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final currentQuestionDisplay = currentQuestionIndex + 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '$currentQuestionDisplay of ${quiz.questions.length} questions',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      quiz.questions[currentQuestionIndex].question,
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    _buildAnswerChoices(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerChoices() {
    var theme = Theme.of(context);
    return Column(
      children: quiz.questions[currentQuestionIndex].choices
          .map(
            (choice) => GestureDetector(
              onTap: () => _handleAnswerSelected(
                quiz.questions[currentQuestionIndex].choices.indexOf(choice),
              ),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12.0),
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  choice,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
