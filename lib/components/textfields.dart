import 'package:flutter/material.dart';

class AttendanceAppTextField extends StatelessWidget {
  const AttendanceAppTextField({
    super.key,
    required TextEditingController batchCodeController,
    required this.hintText,
    required this.label,
    required this.title,
    required this.onChanged,
    this.textInputType = TextInputType.text,
  }) : _batchCodeController = batchCodeController;

  final TextEditingController _batchCodeController;
  final String label;
  final String hintText;
  final String title;
  final TextInputType textInputType;
  final Function(String val) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white60, fontSize: 16),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: _batchCodeController,
          keyboardType: textInputType,
          onChanged: onChanged,
          decoration: InputDecoration(
            label: Text(label),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.red.shade300),
            labelStyle: TextStyle(color: Colors.amber.shade100),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal.shade100, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal.shade400, width: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}
