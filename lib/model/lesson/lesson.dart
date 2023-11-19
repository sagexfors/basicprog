import 'package:basicprog/model/lesson/content.dart';

class Lesson {
  final int id;
  final String title;
  final String description;
  final List<Content> content;
  bool completed;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.completed,
  });

  factory Lesson.fromJson(Map<String, dynamic> json, {bool completed = false}) {
    var contentList = json['content'] as List;
    List<Content> content =
        contentList.map((i) => Content.fromJson(i)).toList();

    return Lesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      content: content,
      completed: completed,
    );
  }

  @override
  String toString() {
    return 'Lesson{id: $id, title: $title, completed: $completed}';
  }
}
