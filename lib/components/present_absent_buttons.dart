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
            buttonColor: Colors.green.shade200,
            onPressed: () {
              listProvider.addToPresentsList();
            },
          ),
          const SizedBox(
            height: 12,
          ),
          MainButton(
            buttonText: 'ABSENT',
            buttonColor: Colors.red.shade200,
            onPressed: () {
              listProvider.addToAbsenteesList();
            },
          ),
        ],
      ),
    );
  }
}
