import 'package:basicprog/Pages/getting_started.dart';
import 'package:basicprog/auth/main_page.dart';
import 'package:basicprog/pages/activities_page.dart';
import 'package:basicprog/pages/change_password_page.dart';
import 'package:basicprog/pages/compiler_page.dart';
import 'package:basicprog/pages/forgot_password_page.dart';
import 'package:basicprog/pages/lessons_page.dart';
import 'package:basicprog/pages/profile_page.dart';
import 'package:basicprog/provider/lessons_provider.dart';
import 'package:basicprog/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/about_us_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LessonsProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const GettingStartedPage(),
          '/about-us': (context) => const AboutUsPage(),
          '/main': (context) => const MainPage(),
          '/profile': (context) => const ProfilePage(),
          '/lessons': (context) => Consumer<LessonsProvider>(
                builder: (context, value, child) {
                  return LessonsPage(
                    lessons: value.lessons,
                  );
                },
              ),
          '/activities': (context) => const ActivitiesPage(),
          '/compiler': (context) => const CompilerPage(),
          '/change-password': (context) => const ChangePasswordPage(),
          '/forgot-password': (context) => const ForgotPasswordPage(),
        },
      ),
    );
  }
}
