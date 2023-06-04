import 'package:basicprog/Widgets/background_image_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [BackgroundImage(imagePath: 'assets/login_register_bg.png')],
      ),
    );
  }
}
