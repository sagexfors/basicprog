import 'package:basicprog/Pages/getting_started.dart';
import 'package:basicprog/auth/main_page.dart';
import 'package:basicprog/constants/routes.dart';
import 'package:basicprog/pages/activities_page.dart';
import 'package:basicprog/pages/assessments/assessments_page.dart';
import 'package:basicprog/pages/change_password_page.dart';
import 'package:basicprog/pages/compiler_page.dart';
import 'package:basicprog/pages/forgot_password_page.dart';
import 'package:basicprog/pages/lessons/lessons_page.dart';
import 'package:basicprog/pages/profile_page.dart';
import 'package:basicprog/pages/quizzes/quizzes_page.dart';

import 'package:basicprog/provider/assessments_provider.dart';
import 'package:basicprog/provider/compiler_provider.dart';
import 'package:basicprog/provider/lessons_provider.dart';
import 'package:basicprog/provider/progress_provider.dart';
import 'package:basicprog/provider/quizzes_provider.dart';
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
        ChangeNotifierProvider(
          create: (context) => QuizzesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CompilerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AssessmentsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProgressProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          gettingStartedRoute: (context) => const GettingStartedPage(),
          aboutUsRoute: (context) => const AboutUsPage(),
          mainRoute: (context) => const MainPage(),
          profileRoute: (context) => const ProfilePage(),
          lessonsRoute: (context) => const LessonsPage(),
          quizzesRoute: (context) => const QuizzesPage(),
          assessmentsRoute: (context) => const AssessmentsPage(),
          activitiesRoute: (context) => const ActivitiesPage(),
          compilerRoute: (context) => Consumer<CompilerProvider>(
                builder: (context, value, child) {
                  return CompilerPage(
                    code: value.code,
                  );
                },
              ),
          changePasswordRoute: (context) => const ChangePasswordPage(),
          forgotPasswordRoute: (context) => const ForgotPasswordPage(),
        },
      ),
    );
  }
}
