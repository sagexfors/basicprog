import 'package:basicprog/Widgets/background_image_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(imagePath: 'assets/login_register_bg.png'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text('Welcome'),
              const SizedBox(height: 20),
              const TextField(),
              const SizedBox(height: 30),
              const TextField(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Log in'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
