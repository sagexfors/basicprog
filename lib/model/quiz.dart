import 'package:basicprog/model/question.dart';

class Quiz {
  String title;
  String description;
  List<Question> questions;

  Quiz({
    required this.title,
    required this.description,
    required this.questions,
  });
}
