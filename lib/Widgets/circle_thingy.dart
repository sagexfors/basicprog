import 'package:flutter/material.dart';

class CircleThing extends StatelessWidget {
  final double opacity;

  const CircleThing({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5, // Set the opacity to 50%
      child: Container(
        width: 200, // Adjust the size of the circle as needed
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              Colors.blue.withOpacity(opacity), // Change the color with opacity
          boxShadow: [
            BoxShadow(
              color: Colors.grey
                  .withOpacity(0.5), // Add a shadow for a modern look
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Set the shadow offset
            ),
          ],
        ),
      ),
    );
  }
}
