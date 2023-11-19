import 'package:basicprog/services/firestore_service.dart';
import 'package:basicprog/model/quiz.dart';
import 'package:flutter/material.dart';

class QuizzesProvider with ChangeNotifier {
  List<Quiz> quizzes;

  QuizzesProvider() : quizzes = [] {
    initialize();
  }

  void initialize() {
    FirestoreService().getQuizzes().then((quizzes) {
      this.quizzes = quizzes;
      notifyListeners();
    });
  }
}
