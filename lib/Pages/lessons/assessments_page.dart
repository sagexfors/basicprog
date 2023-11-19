import 'package:basicprog/Pages/quiz_page.dart';
import 'package:basicprog/model/quiz.dart';
import 'package:basicprog/provider/assessments_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssessmentsPage extends StatelessWidget {
  const AssessmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final assessmentProvider = context.watch<AssessmentsProvider>();
    final quizzes = assessmentProvider.assessments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessments'),
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
    var theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizPage(quiz: quiz),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLeading(theme),
              const SizedBox(width: 16),
              Expanded(child: _buildQuizInfo(theme, quiz)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(ThemeData theme) {
    return Icon(
      Icons.quiz, // Quiz-related icon
      size: 30,
      color: theme.colorScheme.primary,
    );
  }

  Widget _buildQuizInfo(ThemeData theme, Quiz quiz) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          quiz.title,
          style: theme.textTheme.titleLarge,
          overflow: TextOverflow.visible,
          softWrap: true, // Allows long titles to wrap
        ),
        const SizedBox(height: 4),
        quiz.description == ''
            ? Container()
            : Text(
                quiz.description,
                style: theme.textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
      ],
    );
  }
}
