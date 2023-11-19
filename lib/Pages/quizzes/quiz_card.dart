import 'package:basicprog/model/quiz.dart';
import 'package:basicprog/pages/quizzes/quiz_page.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final int quizNumber;
  final Quiz quiz;
  final double? score;

  const QuizCard({
    super.key,
    required this.quizNumber,
    required this.quiz,
    required this.score,
  });

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
          softWrap: true,
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
        // Score Display
        const SizedBox(height: 8),
        _buildScoreIndicator(theme, score),
      ],
    );
  }

  Widget _buildScoreIndicator(ThemeData theme, double? score) {
    return score != null
        ? Row(
            children: [
              Icon(Icons.score, color: theme.colorScheme.secondary),
              const SizedBox(width: 4),
              Text(
                'Score: ${score.toInt().toString()} %',
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
            ],
          )
        : Text(
            'No score',
            style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(150)),
          );
  }
}
