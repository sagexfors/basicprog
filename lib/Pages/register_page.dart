import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        body: Stack(
          children: [RegisterForm(showLoginPage: widget.showLoginPage)],
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
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate() && _validateConfirmPassword()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Registration successful, perform any additional actions here
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
          const SizedBox(height: 24.0),
          if (_errorText != null)
            Text(
              _errorText!,
              style: const TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 12.0),
          RegisterButton(
            onPressed: _register,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: Text(
                  'Sign in here.',
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

class EmailTextFormField extends StatelessWidget {
  final TextEditingController emailController;

  const EmailTextFormField({required this.emailController, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: const Icon(Icons.email),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an email';
          }
          return null;
        },
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;
  final String labelText;

  const PasswordTextField({
    required this.passwordController,
    Key? key,
    required this.labelText,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: widget.passwordController,
        obscureText: _obscureText,
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          return null;
        },
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Register'),
    );
  }
}
