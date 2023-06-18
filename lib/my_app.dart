import 'package:flutter/material.dart';

import '../Auth/main_page.dart';
import '../Pages/about_us_page.dart';

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
