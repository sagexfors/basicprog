import 'package:basicprog/services/firestore_service.dart';
import 'package:basicprog/model/lesson/lesson.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LessonsProvider with ChangeNotifier {
  List<Lesson> lessons = [];

  final Map<String, bool> _completedLessons = {};

  Map<String, bool> get completedLessons => _completedLessons;

  void initialize() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Fetch the current user's lessons from Firestore
      final userDoc = await FirestoreService().getUserDocument(currentUser.uid);
      Map<String, dynamic> userLessonsRaw = userDoc.data()?['lessons'] ?? {};

      // Convert each entry to extract the 'completed' value
      Map<String, bool> userLessons = userLessonsRaw.map((key, value) {
        if (value is Map && value.containsKey('completed')) {
          return MapEntry(key, value['completed'] as bool);
        } else {
          return MapEntry(
            key,
            false,
          ); // Default to false if the structure is not as expected
        }
      });

      // Update the _completedLessons map
      _completedLessons.clear(); // Clear the existing entries
      _completedLessons.addAll(userLessons);
    }

    // Fetch all lessons
    FirestoreService().getLessons().then((lessons) {
      this.lessons = lessons;
      notifyListeners();
    });
  }

  void toggleLessonCompletion(String lessonId, bool isCompleted) {
    _completedLessons[lessonId] = isCompleted;
    notifyListeners();
  }

  void clear() {
    _completedLessons.clear();
    notifyListeners();
  }
}
