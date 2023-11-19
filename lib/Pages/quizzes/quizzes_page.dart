import 'package:basicprog/pages/quizzes/quiz_card.dart';
import 'package:basicprog/provider/quizzes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizzesPage extends StatelessWidget {
  const QuizzesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizzesProvider = context.watch<QuizzesProvider>();
    final quizzes = quizzesProvider.quizzes;
    final quizzesScore = quizzesProvider.quizzesScore;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzes'),
      ),
      body: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          final quizNumber = index + 1;
          final quizScore = quizzesScore[quiz.id.toString()];
          return QuizCard(
            quiz: quiz,
            quizNumber: quizNumber,
            score: quizScore,
          );
        },
      ),
    );
  }
}
