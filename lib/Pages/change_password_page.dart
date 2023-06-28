import 'package:basicprog/Widgets/auth_button.dart';
import 'package:basicprog/Widgets/password_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  String _errorMessage = '';

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final User? user = FirebaseAuth.instance.currentUser;

      try {
        await user?.updatePassword(_passwordController.text);
        if (context.mounted && user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password changed successfully.'),
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error updating password: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PasswordTextField(
                  controller: _passwordController,
                  labelText: 'New Password',
                ),
                const SizedBox(height: 24),
                PasswordTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                ),
                const SizedBox(height: 16.0),
                AuthButton(
                  name: 'Reset Password',
                  onPressed: () => _changePassword(context),
                ),
                const SizedBox(height: 8.0),
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
