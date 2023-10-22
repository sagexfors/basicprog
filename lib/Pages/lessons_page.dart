import 'package:flutter/material.dart';

import '../model/lesson.dart';

class LessonsPage extends StatelessWidget {
  final List<Lesson> lessons;

  const LessonsPage({Key? key, required this.lessons}) : super(key: key);

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
          return LessonCard(
            lesson: lesson,
            lessonNumber: lessonNumber,
          );
        },
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final int lessonNumber;

  final Lesson lesson;

  const LessonCard({
    Key? key,
    required this.lessonNumber,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = lesson.title;
    var description = lesson.description;
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
        title: Text(title!),
        subtitle: Text(description!),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonPage(
                lessonNumber: lessonNumber,
                lesson: lesson,
              ),
            ),
          );
        },
      ),
    );
  }
}

class LessonPage extends StatelessWidget {
  final int lessonNumber;
  final Lesson lesson;

  const LessonPage({Key? key, required this.lessonNumber, required this.lesson})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = lesson.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lesson.content?.length,
              itemBuilder: (context, index) {
                final contentItem = lesson.content?[index];
                final contentType = contentItem?.type;
                final contentItemText = contentItem?.text ?? '';
                return ListTile(
                  title: Text(
                    contentItemText,
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
