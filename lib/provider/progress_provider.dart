import 'package:basicprog/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProgressProvider with ChangeNotifier {
  double _lessonsProgress = 0.0;
  double _quizzesProgress = 0.0;
  double _assessmentsProgress = 0.0;

  double get lessonsProgress => _lessonsProgress;
  double get quizzesProgress => _quizzesProgress;
  double get assessmentsProgress => _assessmentsProgress;

  void initialize() async {
    try {
      await fetchLessonsProgress();
      await fetchQuizzesProgress();
      await fetcAssessmentsProgress();
    } catch (e) {
      throw ("Error initializing progress provider: $e");
    }
  }

  // Method to update lesson progress
  void updateLessonsProgress(double progress) {
    _lessonsProgress = progress;
    notifyListeners();
  }

  // Method to update quizzes progress
  void updateQuizzesProgress(double progress) {
    _quizzesProgress = progress;
    notifyListeners();
  }

  // Method to update assessments progress
  void updateAssessmentsProgress(double progress) {
    _assessmentsProgress = progress;
    notifyListeners();
  }

  Future<void> fetchLessonsProgress() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw ("User is not logged in");
      }
      final userDoc = await FirestoreService().getUserDocument(user.uid);
      Map<String, dynamic> userLessons = userDoc.data()?['lessons'] ?? {};
      int completedCount = userLessons.values
          .where((lesson) => lesson['completed'] == true)
          .length;
      int totalLessons = 26;
      final progress = completedCount / totalLessons;
      updateLessonsProgress(progress);
    } catch (e) {
      throw ("Error fetching lessons progress: $e");
    }
  }

  Future<void> fetchQuizzesProgress() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw ("User is not logged in");
      }
      final userDoc = await FirestoreService().getUserDocument(user.uid);
      Map<String, dynamic> userQuizzes = userDoc.data()?['quizzes'] ?? {};
      int completedCount =
          userQuizzes.values.where((quiz) => quiz['score'] == 100).length;
      int totalQuizzes = 22;
      final progress = completedCount / totalQuizzes;
      updateQuizzesProgress(progress);
    } catch (e) {
      throw ("Error fetching quizzes progress: $e");
    }
  }

  Future<void> fetcAssessmentsProgress() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw ("User is not logged in");
      }
      final userDoc = await FirestoreService().getUserDocument(user.uid);
      Map<String, dynamic> userAssessments =
          userDoc.data()?['assessments'] ?? {};
      int completedCount = userAssessments.values
          .where((assesment) => assesment['score'] == 100)
          .length;
      int totalQuizzes = 3;
      final progress = completedCount / totalQuizzes;
      updateAssessmentsProgress(progress);
    } catch (e) {
      throw ("Error fetching assesments progress: $e");
    }
  }

  void clear() {
    _lessonsProgress = 0.0;
    _quizzesProgress = 0.0;
    _assessmentsProgress = 0.0;
    notifyListeners();
  }
}
