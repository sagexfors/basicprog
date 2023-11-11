import 'package:basicprog/model/lesson.dart';
import 'package:basicprog/pages/lessons/lesson_widget.dart';
import 'package:flutter/material.dart';

class LessonTile extends StatelessWidget {
  final int lessonNumber;

  final Lesson lesson;

  const LessonTile({
    super.key,
    required this.lessonNumber,
    required this.lesson,
  });

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
              builder: (context) => LessonWidget(
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
