import 'package:basicprog/model/lesson/lesson.dart';
import 'package:basicprog/pages/lessons/lesson_tile.dart';
import 'package:flutter/material.dart';

class LessonsPage extends StatelessWidget {
  final List<Lesson> lessons;

  const LessonsPage({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          final lessonNumber = index + 1;
          return LessonTile(
            lesson: lesson,
            lessonNumber: lessonNumber,
          );
        },
      ),
    );
  }
}
