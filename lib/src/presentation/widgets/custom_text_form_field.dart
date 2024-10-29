import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constant/colour.dart';

class CustomTextFormField extends StatelessWidget {
  final Key formKey;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int maxLength;
  final TextInputType textInputType;
  final String labelText;

  const CustomTextFormField({
    super.key,
    required this.formKey,
    required this.controller,
    this.validator,
    this.onChanged,
    required this.maxLength,
    required this.textInputType,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      // autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLength: maxLength,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: labelText,
          filled: true,
          fillColor: Colour.backGround,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.0.r),
          ),
        ),
      ),
    );
  }
}
