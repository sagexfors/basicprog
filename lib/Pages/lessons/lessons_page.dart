import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basicprog/provider/lessons_provider.dart'; // Import your LessonsProvider
import 'package:basicprog/pages/lessons/lesson_tile.dart';

class LessonsPage extends StatefulWidget {
  const LessonsPage({super.key});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  @override
  void initState() {
    context.read<LessonsProvider>().initialize(); // Initialize the provider
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Access the lessons and completedLessons from the provider
    final lessonsProvider = context.watch<LessonsProvider>();
    final lessons = lessonsProvider.lessons;
    final completedLessons = lessonsProvider.completedLessons;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          final lessonNumber = index + 1;
          // Check if the lesson is completed
          final isCompleted = completedLessons[lesson.id.toString()] ?? false;

          return LessonTile(
            lesson: lesson,
            lessonNumber: lessonNumber,
            completed: isCompleted, // Pass the completed status
          );
        },
      ),
    );
  }
}
