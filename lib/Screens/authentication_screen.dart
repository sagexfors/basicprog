import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [BackgroundImage(), AuthButtons()],
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

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/auth_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
