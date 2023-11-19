import 'package:basicprog/pages/assessments/assessments_card.dart';
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
          return AssessmentCard(
            quiz: quiz,
            quizNumber: quizNumber,
          );
        },
      ),
    );
  }
}
