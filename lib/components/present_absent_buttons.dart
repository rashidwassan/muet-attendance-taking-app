import 'package:attendance_app/components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/students_list_provider.dart';

class OptionButtons extends StatelessWidget {
  const OptionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentListProvider>(
      builder: (context, listProvider, child) => Column(
        children: [
          MainButton(
            buttonText: 'PRESENT',
            buttonColor: const Color(0xFFC5FAD6),
            onPressed: () {
              listProvider.addToPresentsList();
            },
          ),
          const SizedBox(
            height: 12,
          ),
          MainButton(
            buttonText: 'ABSENT',
            textColor: Colors.white,
            buttonColor: const Color(0xFFFA6166),
            onPressed: () {
              listProvider.addToAbsenteesList();
            },
          ),
        ],
      ),
    );
  }
}
