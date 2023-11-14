import 'package:basicprog/Pages/quiz_page.dart';
import 'package:flutter/material.dart';

import '../model/quiz.dart';

class QuizzesPage extends StatelessWidget {
  final List<Quiz> quizzes;

  const QuizzesPage({Key? key, required this.quizzes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzes'),
      ),
      body: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          final quizNumber = index + 1;
          return QuizCard(
            quiz: quiz,
            quizNumber: quizNumber,
          );
        },
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  final int quizNumber;
  final Quiz quiz;

  const QuizCard({
    Key? key,
    required this.quizNumber,
    required this.quiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            quizNumber.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(quiz.title),
        subtitle: quiz.description == '' ? null : Text(quiz.description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizPage(
                quiz: quiz,
              ),
            ),
          );
        },
      ),
    );
  }
}
