import 'package:basicprog/model/lesson/content.dart';

class Lesson {
  final String title;
  final String description;
  final List<Content> content;

  Lesson({
    required this.title,
    required this.description,
    required this.content,
  });
}
