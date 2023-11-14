import 'package:flutter/material.dart';
import '../fuzzy_logic.dart';
import '../model/quiz.dart';

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
      Map<String, dynamic> result = quizPassFailAlgorithm(userResponses);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Quiz Completed"),
            content: Column(
              children: [
                Text("Your score: ${result['score']}"),
                Text("Result: ${result['result']}"),
              ],
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
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              quiz.questions[currentQuestionIndex].question,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Column(
              children: List<Widget>.generate(
                quiz.questions[currentQuestionIndex].choices.length,
                (index) => GestureDetector(
                  onTap: () {
                    _handleAnswerSelected(index);
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors
                            .blue, // Change the color to your desired border color
                        width: 2.0, // Adjust the border width as needed
                      ),
                      borderRadius: BorderRadius.circular(
                        8,
                      ), // Adjust the border radius as needed
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      quiz.questions[currentQuestionIndex].choices[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(
                          255,
                          82,
                          82,
                          82,
                        ), // Change the text color to your desired color
                        fontSize: 16, // Adjust the font size as needed
                        fontWeight:
                            FontWeight.bold, // Adjust the font weight as needed
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
