import 'dart:math';

import 'package:attendance_app/components/desired_student_wrap.dart';
import 'package:attendance_app/components/dialogs.dart';
import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/components/present_absent_buttons.dart';
import 'package:attendance_app/db/colors.dart';
import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:attendance_app/providers/user_data_provider.dart';
import 'package:attendance_app/screens/report_page.dart';
import 'package:attendance_app/screens/students_record_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AttendancePage extends StatefulWidget {
  static const String routeName = '/attendance-page';
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late String report;

  void generateReport() {
    report = Provider.of<StudentListProvider>(context, listen: false)
        .getRollsFromDesiredList();

    if (report == '') report = 'Nothing to display!  ';
    Navigator.pushNamed(context, ReportPage.routeName, arguments: report);
  }

  late List<String> userInfo =
      Provider.of<UserDataProvider>(context, listen: false).userData ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        title: Text('${userInfo[1]}${userInfo[2]} - ${userInfo[3]}'),
        actions: [
          IconButton(
            onPressed: () {
              showRetakeConfirmationDialog(context);
            },
            tooltip: 'Retake Attendance',
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, StudentsRecordPage.routeName);
            },
            tooltip: 'Student Record',
            icon: const Icon(Icons.book),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<StudentListProvider>(
          builder: (context, listProvider, child) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: LightColors.colors[
                          Random().nextInt(LightColors.colors.length - 1)],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              listProvider
                                  .allStudents[listProvider.currentStudent]
                                  .rollNumber,
                              style: TextStyle(
                                fontSize: 55,
                                fontFamily: GoogleFonts.concertOne().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              listProvider
                                  .allStudents[listProvider.currentStudent]
                                  .name,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: GoogleFonts.concertOne().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
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
                  Column(
                    children: [
                      MainButton(
                        buttonText: 'Generate Report',
                        onPressed: generateReport,
                        buttonColor: LightColors.colors[
                            Random().nextInt(LightColors.colors.length - 1)],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text('Please select the list to be generated:'),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                listProvider.ifGetAbsenteesList = false;
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                height: 45,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: listProvider.ifGetAbsenteesList
                                      ? Colors.white38
                                      : Colors.green.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'PRESENT Students',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                listProvider.ifGetAbsenteesList = true;
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                height: 45,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: !listProvider.ifGetAbsenteesList
                                      ? Colors.white38
                                      : Colors.green.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'ABSENT Students',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  const OptionButtons(),
                const Divider(
                  height: 32,
                  color: Colors.white,
                ),
                DesiredStudentRollNumbersDisplay(LightColors.colors),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
