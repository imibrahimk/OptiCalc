import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0), // Border width
      decoration:
          const BoxDecoration(color: Color(0xff00008B), shape: BoxShape.circle),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(60.0.r), // Image radius
          child: Image.asset(image),
        ),
      ),
    );
  }
}
