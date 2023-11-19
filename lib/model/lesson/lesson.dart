import 'package:basicprog/model/lesson/content.dart';

class Lesson {
  final int id;
  final String title;
  final String description;
  final List<Content> content;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    var contentList = json['content'] as List;
    List<Content> content =
        contentList.map((i) => Content.fromJson(i)).toList();

    return Lesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      content: content,
    );
  }
}
