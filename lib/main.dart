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

//TODO: ADD VIDEO TUTORIALS
//TODO:  get started shared preference
//todo: add sidebar for video tutorials.
// COMPILER, THERE SHOULD BE A CANCEL BUTTON
// ALSO IF RESPONSE 400, IF TAKES TOO LONG, CANCEL