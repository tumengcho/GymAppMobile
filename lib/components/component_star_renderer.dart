import 'package:flutter/material.dart';

class StarRenderer extends StatelessWidget {
  final int numStars;
  final double size;

  const StarRenderer({super.key, required this.numStars, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < numStars ? Icons.star : Icons.star_outline,
          size: size,
          color: const Color(0xFFD3FF55),
        );
      }),
    );
  }
}
