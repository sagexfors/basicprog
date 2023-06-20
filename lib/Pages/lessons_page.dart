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
        title: Text(lesson.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Title: ${lesson.title}',
            //   style: const TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 16),
            // const Text(
            //   'Content:',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lesson.content.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    lesson.content[index],
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
