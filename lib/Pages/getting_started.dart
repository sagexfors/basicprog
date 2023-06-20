import 'package:basicprog/Auth/main_page.dart';
import 'package:flutter/material.dart';

import '../Widgets/auth_button.dart';
import '../Widgets/circle_thingy.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 96),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/getting_started.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    'Welcome to Basic',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Basic; your guide on learning Programming Languages',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 120),
                  AuthButton(
                    name: 'Get Started',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Positioned(
              top: -80,
              left: -100,
              child: CircleThing(opacity: 0.7),
            ),
            const Positioned(
              top: -140,
              left: -10,
              child: CircleThing(opacity: 0.7),
            ),

            // LoginForm(showRegisterPage: widget.showRegisterPage)
          ],
        ),
      ),
    );
  }
}
