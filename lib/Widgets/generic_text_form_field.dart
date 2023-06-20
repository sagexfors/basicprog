import 'package:flutter/material.dart';

class GenericTextFormField extends StatelessWidget {
  final TextEditingController controller;

  final String labelText;

  final IconData icon;

  const GenericTextFormField({
    required this.controller,
    required this.labelText,
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          prefixIcon: Icon(icon),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter a ${labelText.toLowerCase()}";
          }
          return null;
        },
      ),
    );
  }
}
