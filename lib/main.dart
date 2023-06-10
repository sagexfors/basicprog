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
      theme: buildCustomTheme(),
    );
  }
}

ThemeData buildCustomTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: Colors.deepPurple,
    secondary: Colors.deepPurple,
  );

  final ThemeData base = ThemeData.from(colorScheme: colorScheme);

  return base.copyWith(
    useMaterial3: false,
    colorScheme: colorScheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
    ),
  );
}
