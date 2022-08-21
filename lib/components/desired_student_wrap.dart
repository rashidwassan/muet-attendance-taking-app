import 'dart:math';

import 'package:attendance_app/constants/images.dart';
import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesiredStudentRollNumbersDisplay extends StatelessWidget {
  const DesiredStudentRollNumbersDisplay(this.colors, {super.key});
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentListProvider>(
      builder: (context, listProvider, child) => Column(
        children: [
          Text(
            listProvider.ifGetAbsenteesList
                ? 'Absent Students'
                : 'Present Students',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          if (listProvider.absentStudents.isEmpty)
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Image.asset(
                    Images.smiley,
                    width: 60,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'No Absentees so far!',
                    style: TextStyle(color: Colors.white60),
                  )
                ],
              ),
            )
          else
            Wrap(
              children: [
                for (int i = 0; i < listProvider.desiredStudents.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Chip(
                      // onDeleted: () {},
                      // deleteIcon: Icon(
                      //   Icons.delete,
                      //   size: 19,
                      //   color: Colors.red.shade400,
                      // ),
                      backgroundColor:
                          colors[Random().nextInt(colors.length - 1)],
                      label: Text(
                        listProvider
                            .allStudents[listProvider.desiredStudents[i]],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            )
        ],
      ),
    );
  }
}
