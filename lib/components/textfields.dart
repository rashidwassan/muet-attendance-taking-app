import 'package:flutter/material.dart';

class AttendanceAppTextField extends StatelessWidget {
  const AttendanceAppTextField({
    super.key,
    required TextEditingController batchCodeController,
    required this.hintText,
    required this.label,
    required this.title,
    required this.onChanged,
    required this.onSubmitted,
    this.focusNode,
    this.textInputType = TextInputType.text,
  }) : _batchCodeController = batchCodeController;

  final TextEditingController _batchCodeController;
  final String label;
  final String hintText;
  final String title;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final Function(String val) onChanged;
  final Function(String val) onSubmitted;

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
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: _batchCodeController,
            keyboardType: textInputType,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            validator: (value) {
              if (value!.isEmpty) return 'Field cannot be left empty!';
              return null;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              // label: Text(label),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white38),
              labelStyle: TextStyle(color: Colors.amber.shade100),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.teal.shade100,
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.teal.shade400, width: 0.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red.shade300, width: 0.5),
              ),
              errorStyle: TextStyle(color: Colors.redAccent.shade200),
            ),
          ),
        ),
      ],
    );
  }
}
