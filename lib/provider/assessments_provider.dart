import 'package:basicprog/services/firestore_service.dart';
import 'package:basicprog/model/quiz.dart';
import 'package:flutter/material.dart';

class AssessmentsProvider with ChangeNotifier {
  List<Quiz> assessments;

  AssessmentsProvider() : assessments = [] {
    initialize();
  }

  void initialize() {
    FirestoreService().getQuestions().then((assessments) {
      this.assessments = assessments;
      notifyListeners();
    });
  }
}
