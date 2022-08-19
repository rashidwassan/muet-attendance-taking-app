import 'dart:math';

import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:attendance_app/screens/report_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/present_absent_buttons.dart';

class AttendancePage extends StatefulWidget {
  static const String routeName = '/attendance-page';
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late String report;
  List<Color> colors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.blueGrey.shade100,
    Colors.deepPurpleAccent.shade100,
    Colors.grey.shade100,
    Colors.pink.shade100,
    Colors.blueGrey.shade100,
    Colors.tealAccent.shade100,
    Colors.teal.shade100,
  ];

  void generateReport() {
    report =
        '${DateTime.now()}\n${Provider.of<StudentListProvider>(context, listen: false).getRollsOfAbsentees()}';
    Navigator.pushNamed(context, ReportPage.routeName, arguments: report);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<StudentListProvider>(
            builder: (context, listProvider, child) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      decoration: BoxDecoration(
                        color: colors[Random().nextInt(colors.length - 1)],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          listProvider.allStudents[listProvider.currentStudent],
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  if (listProvider.currentStudent ==
                      listProvider.allStudents.length - 1)
                    MainButton(
                      buttonText: 'Generate Report',
                      onPressed: generateReport,
                      buttonColor: Colors.amberAccent.shade100,
                    )
                  else
                    const OptionButtons(),
                  const Divider(
                    height: 32,
                    color: Colors.white,
                  ),
                  const Text(
                    'Absentees',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    children: [
                      for (int i = 0;
                          i < listProvider.absentStudents.length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            onDeleted: () {},
                            deleteIcon: const Icon(
                              Icons.delete,
                              size: 19,
                            ),
                            backgroundColor:
                                colors[Random().nextInt(colors.length - 1)],
                            label: Text(
                              listProvider
                                  .allStudents[listProvider.absentStudents[i]],
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
