import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constant/colour.dart';

class TitleTextWidget extends StatelessWidget {
  final String text;

  const TitleTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colour.darkBlue,
        fontSize: 16.0.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
