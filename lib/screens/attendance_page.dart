import 'dart:math';

import 'package:attendance_app/components/desired_student_wrap.dart';
import 'package:attendance_app/components/dialogs.dart';
import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/components/present_absent_buttons.dart';
import 'package:attendance_app/constants/images.dart';
import 'package:attendance_app/db/colors.dart';
import 'package:attendance_app/db/prefs.dart';
import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:attendance_app/providers/user_data_provider.dart';
import 'package:attendance_app/screens/report_page.dart';
import 'package:attendance_app/screens/students_record_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AttendancePage extends StatefulWidget {
  static const String routeName = '/attendance-page';
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late String report;
  final String date = DateFormat.yMMMEd().format(DateTime.now());

  void generateReport() {
    report = Provider.of<StudentListProvider>(context, listen: false)
        .getRollsFromDesiredList();

    if (report == '') report = 'No student to display.  ';
    Navigator.pushNamed(context, ReportPage.routeName, arguments: report);
  }

  List<String>? userInfo;

  @override
  void initState() {
    super.initState();
    loadData();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await showSubjectNameDialog(context);
    });
  }

  void loadData() async {
    await PrefsDBService.getUserInfo().then(
      (value) => Provider.of<UserDataProvider>(context, listen: false)
          .userData = userInfo = value,
    );
    setState(() {});
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   userInfo = Provider.of<UserDataProvider>(context, listen: false).userData;
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: userInfo == null
            ? const SizedBox()
            : Consumer<StudentListProvider>(
                builder: (context, listData, child) => Column(
                  children: [
                    Text(
                      '${userInfo![1]}${userInfo![2]}-${userInfo![3]} ${listData.subjectName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
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
            child: listProvider.allStudents.length < 2
                ? Column(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      LottieBuilder.asset(
                        Images.sadAnim,
                        width: 100,
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text(
                            'Seems like no student is added in to the database yet! Please start adding students by tapping that book icon in upper right corner.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.2,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: LightColors.colors[Random()
                                .nextInt(LightColors.colors.length - 1)],
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
                                        .allStudents[
                                            listProvider.currentStudent]
                                        .rollNumber,
                                    style: const TextStyle(
                                      fontSize: 55,
                                      fontFamily: 'ConcertOne',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    listProvider
                                        .allStudents[
                                            listProvider.currentStudent]
                                        .name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'ConcertOne',
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
                              buttonText: 'GENERATE REPORT',
                              onPressed: generateReport,
                              buttonColor: LightColors.colors[Random()
                                  .nextInt(LightColors.colors.length - 1)],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text(
                              'Please select the list to be generated:',
                            ),
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
                                      duration:
                                          const Duration(milliseconds: 250),
                                      height: 45,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: listProvider.ifGetAbsenteesList
                                            ? Colors.white38
                                            : LightColors
                                                .colors[Random().nextInt(
                                                LightColors.colors.length - 1,
                                              )],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'PRESENT Students',
                                          style:
                                              TextStyle(color: Colors.black87),
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
                                      duration:
                                          const Duration(milliseconds: 250),
                                      height: 45,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: !listProvider.ifGetAbsenteesList
                                            ? Colors.white38
                                            : LightColors
                                                .colors[Random().nextInt(
                                                LightColors.colors.length - 1,
                                              )],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'ABSENT Students',
                                          style:
                                              TextStyle(color: Colors.black87),
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
                        color: Colors.white60,
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
