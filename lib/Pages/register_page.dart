import 'package:basicprog/Widgets/generic_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/auth_button.dart';
import '../Widgets/circle_thingy.dart';
import '../Widgets/email_text_form_field.dart';
import '../Widgets/password_text_form_field.dart';

// TODO: extract authenatication thing outside
class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    const SizedBox(height: 60),
                    RegisterForm(showLoginPage: widget.showLoginPage),
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
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.showLoginPage});
  final VoidCallback showLoginPage;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate() && _validateConfirmPassword()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();
      try {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(
              userCredential.user!.uid,
            )
            .set({'name': name});
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'email-already-in-use') {
            _errorText =
                'The email address is already in use by another account.';
          } else if (e.code == 'invalid-email') {
            _errorText = 'The email address is invalid.';
          } else if (e.code == 'weak-password') {
            _errorText = 'The password is too weak.';
          } else {
            _errorText = 'Registration failed. Please try again later.';
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
            'Welcome to Basic;',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(
            height: 64,
          ),
          GenericTextFormField(
            controller: _nameController,
            labelText: 'Name',
          ),
          const SizedBox(height: 16.0),
          EmailTextFormField(emailController: _emailController),
          const SizedBox(height: 16.0),
          PasswordTextField(
            passwordController: _passwordController,
            labelText: 'Password',
          ),
          const SizedBox(height: 16.0),
          PasswordTextField(
            passwordController: _confirmPasswordController,
            labelText: 'Confirm Password',
          ),
          const SizedBox(
            height: 12,
          ),
          if (_errorText != null)
            Text(
              _errorText!,
              style: const TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 6.0),
          AuthButton(
            onPressed: _register,
            name: 'Register',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
              ),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: Text(
                  'Sign in here.',
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _validateConfirmPassword() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _errorText = 'Passwords do not match.';
      });
      return false;
    }

    return true;
  }
}
