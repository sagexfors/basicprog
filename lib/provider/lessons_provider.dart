import 'dart:convert';

import 'package:basicprog/model/lesson/content.dart';
import 'package:basicprog/model/lesson/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LessonsProvider with ChangeNotifier {
  List<Lesson> lessons;

  LessonsProvider() : lessons = [] {
    initialize();
  }

  void initialize() {
    parseLessonsFromJsonFile().then((parsedLessons) {
      lessons = parsedLessons;
      notifyListeners(); // Notify any listeners that the lessons have been updated.
    });
  }

  Future<List<Lesson>> parseLessonsFromJsonFile() async {
    // Read the JSON file into a String
    final jsonString =
        await rootBundle.loadString('assets/temp_repo_lessons.json');

    // Parse the JSON data
    final jsonData = json.decode(jsonString);

    // Extract and parse lessons
    final lessonsData = jsonData['lessons'] as List<dynamic>;
    final lessons = lessonsData.map((lessonData) {
      final contentData = lessonData['content'] as List<dynamic>;
      final content = contentData.map((contentItem) {
        if (contentItem['type'] == 'text') {
          return Content(type: 'text', text: contentItem['text']);
        } else if (contentItem['type'] == 'code') {
          return Content(type: 'code', text: contentItem['code']);
        } else if (contentItem['type'] == 'table') {
          return Content(
            type: 'table',
            table: List<List<dynamic>>.from(contentItem['table']),
          );
        }
        return Content(type: 'text', text: '');
      }).toList();
      return Lesson(
        title: lessonData['title'],
        description: lessonData['description'],
        content: content,
      );
    }).toList();

    return lessons;
  }
}
