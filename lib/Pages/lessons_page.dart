import 'package:flutter/material.dart';

class Lesson {
  String title;
  String description;
  List<String> content;

  Lesson({
    required this.title,
    required this.description,
    required this.content,
  });
}

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
        title: Text(lesson.title),
        subtitle: Text(lesson.description),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson $lessonNumber'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Title: ${lesson.title}'),
            Text('Description: ${lesson.description}'),
            const Text('Content:'),
            Expanded(
              child: ListView.builder(
                itemCount: lesson.content.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(lesson.content[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
