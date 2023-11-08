// import 'dart:convert';

// import 'package:basicprog/model/lesson.dart';
// import 'package:basicprog/model/quiz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class QuizzesProvider with ChangeNotifier {
//   List<Quiz> quizzes;

//   QuizzesProvider() : quizzes = [] {
//     initialize();
//   }

//   void initialize() {
//     parseQuizzesFromJsonFile().then((parsedQuizzes) {
//       quizzes = parsedQuizzes;
//       notifyListeners(); // Notify any listeners that the lessons have been updated.
//     });
//   }

//   Future<List<Quiz>> parseQuizzesFromJsonFile() async {
//     // Read the JSON file into a String
//     final jsonString =
//         await rootBundle.loadString('assets/temp_repo_quizzes.json');

//     // Parse the JSON data
//     final jsonData = json.decode(jsonString);

//     // Extract and parse lessons
//     final lessonsData = jsonData['lessons'] as List<dynamic>;
//     final lessons = lessonsData.map((lessonData) {
//       final contentData = lessonData['content'] as List<dynamic>;
//       final content = contentData.map((contentItem) {
//         if (contentItem['type'] == 'text') {
//           return Content(type: 'text', text: contentItem['text']);
//         } else if (contentItem['type'] == 'code') {
//           return Content(type: 'code', text: contentItem['code']);
//         }
//         return Content(type: 'text', text: '');
//       }).toList();
//       return Lesson(
//         title: lessonData['title'],
//         description: lessonData['description'],
//         content: content,
//       );
//     }).toList();

//     return lessons;
//   }
// }


// TODO: COMPILE A BUNCH OF QUIZZES