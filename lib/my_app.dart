import 'package:basicprog/Pages/getting_started.dart';
import 'package:flutter/material.dart';

import '../Pages/about_us_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GettingStartedPage(),
        '/about-us': (context) => const AboutUsPage(),
      },
    );
  }
}
