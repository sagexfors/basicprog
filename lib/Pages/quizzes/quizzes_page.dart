import 'package:basicprog/pages/quizzes/quiz_card.dart';
import 'package:basicprog/provider/quizzes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key});

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  @override
  void initState() {
    context.read<QuizzesProvider>().initialize();
    super.initState();
  }

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
          final formattedScore = quizScore != null
              ? double.parse(quizScore.toStringAsFixed(2))
              : null;

          return QuizCard(
            quiz: quiz,
            quizNumber: quizNumber,
            score: formattedScore,
          );
        },
      ),
    );
  }
}
