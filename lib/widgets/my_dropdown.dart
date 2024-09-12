import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final String hintText;
  final List<String> listItem;
  final void Function(String) selectedData;

  const MyDropdown({
    super.key,
    required this.hintText,
    required this.listItem,
    required this.selectedData,
  });

  @override
  State<MyDropdown> createState() => MyDropdownState();
}

class MyDropdownState extends State<MyDropdown> {
  String? initValue;

  // Method to reset dropdown selection
  void resetDropdownSelection() {
    setState(() {
      initValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton(
        isExpanded: true,
        value: initValue,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        hint: Text(
          widget.hintText,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
        items: widget.listItem
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w500),
                )))
            .toList(),
        onChanged: (value) {
          setState(() {
            initValue = value;
          });
          widget.selectedData(value as String);
        },
      ),
    );
  }
}
