import 'package:flutter/material.dart';

class CircularPhoto extends StatelessWidget {
  const CircularPhoto({
    super.key,
    required this.photo,
    required this.borderRadius,
  });

  final String photo;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        border: Border.all(width: 1.0, color: Colors.blue.shade900),
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          photo,
          fit: BoxFit.cover,
          scale: 1.0,
        ),
      ),
    );
  }
}
