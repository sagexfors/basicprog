import 'package:flutter/material.dart';

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
