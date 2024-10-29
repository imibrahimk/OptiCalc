import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextStyle {
  static TextStyle titleStyle(Color color) {
    final titleStyle = TextStyle(
      fontSize: 20.0.sp,
      color: color,
      fontWeight: FontWeight.bold,
    );
    return titleStyle;
  }

  static TextStyle subTitleStyle(Color color) {
    final subTitleStyle = TextStyle(
      fontSize: 18.0.sp,
      color: color,
      fontWeight: FontWeight.bold,
    );
    return subTitleStyle;
  }

  static TextStyle normalTextStyle(Color color) {
    final subTitleStyle = TextStyle(
      fontSize: 14.0.sp,
      color: color,
    );
    return subTitleStyle;
  }

  static TextStyle normalBoldStyle(Color color) {
    final normalBoldStyle = TextStyle(
      fontSize: 14.0.sp,
      color: color,
      fontWeight: FontWeight.w700,
    );
    return normalBoldStyle;
  }
}
