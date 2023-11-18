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



//TODO: COMPILER, ADD ERROR POP UP AND OUTPUT POP UP OR SCREEN?
//TODO: QUIZZES STILL NEED DATA AND FIX THE QUIZ PAGE