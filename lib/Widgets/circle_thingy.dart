import 'package:flutter/material.dart';

class CircleThing extends StatelessWidget {
  final double opacity;

  const CircleThing({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Opacity(
      opacity: 0.5,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(opacity),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
