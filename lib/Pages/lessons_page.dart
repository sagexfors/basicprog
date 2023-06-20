import 'package:flutter/material.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: ListView.builder(
        itemCount: 10, // Number of lesson cards
        itemBuilder: (context, index) {
          final lessonNumber = index + 1;
          return LessonCard(lessonNumber: lessonNumber);
        },
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final int lessonNumber;

  const LessonCard({super.key, required this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            lessonNumber.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text('Lesson $lessonNumber'),
        subtitle: Text('Description of Lesson $lessonNumber'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonPage(lessonNumber: lessonNumber),
            ),
          );
        },
      ),
    );
  }
}

class LessonPage extends StatelessWidget {
  final int lessonNumber;

  const LessonPage({super.key, required this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson $lessonNumber'),
      ),
      body: Center(
        child: Text('Content of Lesson $lessonNumber'),
      ),
    );
  }
}
