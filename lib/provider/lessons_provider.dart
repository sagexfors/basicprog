import 'dart:convert';

import 'package:basicprog/model/lesson/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LessonsProvider with ChangeNotifier {
  List<Lesson> lessons;

  LessonsProvider() : lessons = [] {
    initialize();
  }

  void initialize() {
    parseLessonsFromAsset().then((parsedLessons) {
      lessons = parsedLessons;
      notifyListeners(); // Notify any listeners that the lessons have been updated.
    });
  }

  Future<List<Lesson>> parseLessonsFromAsset() async {
    final jsonString = await rootBundle.loadString('assets/lessons.json');
    final jsonData = json.decode(jsonString);
    var lessonsList = jsonData['lessons'] as List;
    List<Lesson> lessons = lessonsList.map((i) => Lesson.fromJson(i)).toList();
    return lessons;
  }
}
