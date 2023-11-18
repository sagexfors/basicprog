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

//TODO: store lesson completions in users collections (user id, lesson id, completed)
//TODO: store quiz scores in users collections (user id, quiz id, score)
//TODO: store assessment scores in users collections (user id, assessment id, score)
//TODO:
//TODO:
//TODO:
//TODO: