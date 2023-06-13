import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;

  final String name;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(name),
    );
  }
}
