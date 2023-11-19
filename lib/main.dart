import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//TODO: store quiz scores in users collections (user id, quiz id, score)
//TODO: store assessment scores in users collections (user id, assessment id, score)
//TODO: which means i have to fetch the quizzes and assessment again with the score and then build them again with the score if it exists.
// in other words
// 1. fetch the quizzes/assessment
// 2. fetch the scores from users collection
// 3. build the quizzes/assessment with the scores if they exist
// structure for storing scores in users collection

  // users
  //   - user id
  //     - quizzes
  //       - quiz id
  //         - score
  //     - assessments
  //       - assessment id
  //         - score
  //     - lessons
  //       - lesson id
  //         - completed

