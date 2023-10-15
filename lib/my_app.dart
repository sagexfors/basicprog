import 'dart:convert';
import 'dart:io';

import 'package:basicprog/Pages/getting_started.dart';
import 'package:basicprog/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/about_us_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const GettingStartedPage(),
          '/about-us': (context) => const AboutUsPage(),
        },
      ),
    );
  }
}
