import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubtitleWidget extends StatelessWidget {
  final String text;

  const SubtitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: 16.0.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
