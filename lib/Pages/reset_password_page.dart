import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _errorMessage = '';

  void _resetPassword(BuildContext context) async {
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
              children: [
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a new password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _resetPassword(context),
                  child: const Text('Reset Password'),
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
