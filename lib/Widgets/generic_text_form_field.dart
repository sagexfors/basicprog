import 'package:flutter/material.dart';

class GenericTextFormField extends StatelessWidget {
  final TextEditingController controller;

  final String labelText;

  const GenericTextFormField({
    required this.controller,
    required this.labelText,
    super.key,
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
          prefixIcon: const Icon(Icons.person),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter an $labelText";
          }
          return null;
        },
      ),
    );
  }
}
