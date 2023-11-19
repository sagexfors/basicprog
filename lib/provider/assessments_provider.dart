import 'package:basicprog/services/firestore_service.dart';
import 'package:basicprog/model/quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AssessmentsProvider with ChangeNotifier {
  List<Quiz> assessments = [];

  final Map<String, double> _assessmentsScore = {};

  Map<String, double> get assessmentsScore => _assessmentsScore;

  Future<void> initialize() async {
    print("assessment provider is running!");
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Fetch the current user's assessments from Firestore
      final userDoc = await FirestoreService().getUserDocument(currentUser.uid);
      Map<String, dynamic> userAssessmentsRaw =
          userDoc.data()?['assessments'] ?? {};

      // Convert each entry to extract the 'score' value
      Map<String, double> userAssessments = {};
      userAssessmentsRaw.forEach((key, value) {
        if (value is Map && value.containsKey('score')) {
          double score =
              (value['score'] as num).toDouble(); // Convert to double
          userAssessments[key] = score;
        }
      });

      // Update the _assessmentsScore map
      _assessmentsScore.clear(); // Clear the existing entries
      _assessmentsScore.addAll(userAssessments);
    }

    FirestoreService().getQuestions().then((assessments) {
      this.assessments = assessments;
      notifyListeners();
    });
  }

  void updateAssessmentScore(String assessmentId, double score) {
    _assessmentsScore[assessmentId] = score;
    notifyListeners();
  }

  void clear() {
    _assessmentsScore.clear();
    notifyListeners();
  }
}
