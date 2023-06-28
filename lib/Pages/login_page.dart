import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Widgets/auth_button.dart';
import '../Widgets/circle_thingy.dart';
import '../Widgets/email_text_form_field.dart';
import '../Widgets/password_text_form_field.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
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
            LoginForm(showRegisterPage: widget.showRegisterPage)
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.showRegisterPage});
  final VoidCallback showRegisterPage;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  String? _errorText;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'user-not-found') {
            _errorText = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            _errorText = 'Wrong password provided.';
          } else if (e.code == 'invalid-email') {
            _errorText = 'Invalid email address.';
          } else {
            _errorText = 'Login failed. Please try again later.';
          }
        });
      } catch (e) {
        setState(() {
          _errorText = 'An error occurred. Please try again later.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          SvgPicture.asset(
            'assets/images/login_img.svg', // Replace with your SVG file path
            width: 360, // Adjust the desired width
            height: 156, // Adjust the desired height
          ),
          const SizedBox(
            height: 24,
          ),
          EmailTextFormField(emailController: _emailController),
          const SizedBox(height: 16.0),
          PasswordTextField(
            controller: _passwordController,
            labelText: 'Password',
          ),
          const SizedBox(height: 16.0),
          if (_errorText != null)
            Text(
              _errorText!,
              style: const TextStyle(color: Colors.red),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ForgotPasswordPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AuthButton(
            onPressed: _login,
            name: 'Login',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              GestureDetector(
                onTap: widget.showRegisterPage,
                child: Text(
                  'Register now.',
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //todo gesture app to fix login/register page redirect problem
              ),
            ],
          ),
        ],
      ),
    );
  }
}
