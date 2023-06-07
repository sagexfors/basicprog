import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../Widgets/background_image_widget.dart';
import '../firebase_options.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          const BackgroundImage(imagePath: 'assets/login_register_bg.png'),
          FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = FirebaseAuth.instance.currentUser;
                  if (user?.emailVerified ?? false) {
                    print('Verified');
                  } else {
                    print('Please verify your email');
                  }
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to Basic;!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  );
                default:
                  return const Center(child: Text('Loading...'));
              }
            },
          ),
        ],
      ),
    );
  }
}
