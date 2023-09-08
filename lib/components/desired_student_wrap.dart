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
          if (listProvider.desiredStudents.isEmpty)
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Image.asset(
                    listProvider.ifGetAbsenteesList
                        ? Images.smiley
                        : Images.disappointed,
                    width: 60,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    listProvider.ifGetAbsenteesList
                        ? 'No Absentees So Far!'
                        : 'All Students are Absent!',
                    style: const TextStyle(color: Colors.white60),
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
                      deleteButtonTooltipMessage:
                          listProvider.ifGetAbsenteesList
                              ? 'Remove from absentees list'
                              : "Remove from present students' list",
                      onDeleted: () {},
                      deleteIcon: const Icon(
                        Icons.close,
                        size: 15,
                        color: Colors.black87,
                      ),
                      visualDensity: VisualDensity.compact,
                      backgroundColor:
                          colors[Random().nextInt(colors.length - 1)],
                      label: Text(
                        listProvider
                            .allStudents[listProvider.desiredStudents[i]]
                            .rollNumber,
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
