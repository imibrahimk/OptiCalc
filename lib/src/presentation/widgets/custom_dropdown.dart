import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final String hintText;
  final ValueChanged<String?> onChanged;

  // ignore: use_super_parameters
  const CustomDropdown({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedValue,
        hint: Text(
          hintText,
        ),
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(12.0.r),
        onChanged: onChanged, // This callback comes from the parent widget
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
