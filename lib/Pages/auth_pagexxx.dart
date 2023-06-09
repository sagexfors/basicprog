import 'package:flutter/material.dart';
import 'package:basicprog/Widgets/background_image_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BackgroundImage(
            imagePath: 'assets/auth_bg.png',
          ),
          AuthButtons()
        ],
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  const AuthButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 350,
      left: 45,
      child: Column(
        children: [
          _buildButton('Login', () {
            Navigator.pushNamed(context, '/login');
          }),
          const SizedBox(height: 30),
          _buildButton('Register', () {
            Navigator.pushNamed(context, '/register');
          }),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.white70, width: 2),
        ),
        backgroundColor: Colors.transparent,
        minimumSize: const Size(160, 60),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 22, letterSpacing: 2),
      ),
    );
  }
}
