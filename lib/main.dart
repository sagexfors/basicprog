import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:basicprog/Auth/main_page.dart';
import 'package:basicprog/Pages/about_us_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/about-us': (context) => const AboutUsPage(),
      },
    );
  }
}
