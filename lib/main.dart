import 'package:flutter/material.dart';
import 'package:basicprog/Screens/home_screen.dart';
import 'package:basicprog/Screens/login_screen.dart';
import 'package:basicprog/Screens/register_screen.dart';
import 'package:basicprog/Screens/about_us_screen.dart';
import 'package:basicprog/Screens/authentication_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/auth',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about-us': (context) => const AboutUsScreen(),
        '/auth': (context) => const AuthScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
