import 'package:basicprog/services/firestore_service.dart';
import 'package:basicprog/model/quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizzesProvider with ChangeNotifier {
  List<Quiz> quizzes = [];

  final Map<String, double> _quizzesScore = {};

  Map<String, double> get quizzesScore => _quizzesScore;

  Future<void> initialize() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Fetch the current user's quizzes from Firestore
      final userDoc = await FirestoreService().getUserDocument(currentUser.uid);
      Map<String, dynamic> userQuizzesRaw = userDoc.data()?['quizzes'] ?? {};

      // Convert each entry to extract the 'score' value
      Map<String, double> userQuizzes = {};
      userQuizzesRaw.forEach((key, value) {
        if (value is Map && value.containsKey('score')) {
          double score =
              (value['score'] as num).toDouble(); // Convert to double
          userQuizzes[key] = score;
        }
      });

      // Update the _quizzesScore map
      _quizzesScore.clear(); // Clear the existing entries
      _quizzesScore.addAll(userQuizzes);
    }

    FirestoreService().getQuizzes().then((quizzes) {
      this.quizzes = quizzes;
      notifyListeners();
    });
  }

  void updateQuizScore(String quizId, double score) {
    _quizzesScore[quizId] = score;
    notifyListeners();
  }

  void clear() {
    _quizzesScore.clear();
    notifyListeners();
  }
}
