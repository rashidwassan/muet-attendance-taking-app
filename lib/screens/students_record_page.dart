import 'dart:math';

import 'package:attendance_app/components/dialogs.dart';
import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/constants/images.dart';
import 'package:attendance_app/db/colors.dart';
import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StudentsRecordPage extends StatefulWidget {
  static const String routeName = '/students-record-page';
  const StudentsRecordPage({super.key});

  @override
  State<StudentsRecordPage> createState() => _StudentsRecordPageState();
}

class _StudentsRecordPageState extends State<StudentsRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Student Database'),
        actions: [
          IconButton(
            tooltip: 'Add New Student',
            onPressed: () {
              showStudentDataInputDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Consumer<StudentListProvider>(
            builder: (context, listProvider, child) {
          return Column(
            children: [
              if (listProvider.allStudents.length > 1)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listProvider.allStudents.length,
                    itemBuilder: (context, index) {
                      return listProvider.allStudents.length - 1 != index
                          ? Dismissible(
                              confirmDismiss: (v) async {
                                return showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return CupertinoAlertDialog(
                                      title: const Text('Please Confirm'),
                                      content: Text(
                                          'Are you sure to remove ${listProvider.allStudents[index]}?'),
                                      actions: [
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          isDefaultAction: true,
                                          isDestructiveAction: true,
                                          child: const Text('Yes'),
                                        ),
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text('No'),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              onDismissed: (direction) {
                                Provider.of<StudentListProvider>(
                                  context,
                                  listen: false,
                                ).deleteStudentDataFromDB(
                                  index,
                                  boxName: 'studentsRecord',
                                );
                              },
                              background: Row(
                                children: [
                                  const Spacer(),
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red.shade300,
                                  )
                                ],
                              ),
                              key: Key(
                                listProvider.allStudents[index].rollNumber,
                              ),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color:
                                      TranslucentColors.colors[Random().nextInt(
                                    TranslucentColors.colors.length - 1,
                                  )],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  title: Text(
                                    listProvider.allStudents[index].rollNumber,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    listProvider.allStudents[index].name,
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      CupertinoIcons.pencil_circle,
                                    ),
                                    onPressed: () {
                                      showStudentDataInputDialog(
                                        context,
                                        student:
                                            listProvider.allStudents[index],
                                        indexForUpdation: index,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                )
              else
                Column(
                  children: [
                    LottieBuilder.asset(Images.sadAnim),
                    const Text(
                      'No students found in the record. Please tap that green button to start adding students.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 24,
                    )
                  ],
                ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 50,
                child: MainButton(
                  buttonText: '+ ADD Student',
                  textColor: Colors.white,
                  onPressed: () {
                    showStudentDataInputDialog(context);
                  },
                  buttonColor: Colors.green.shade400,
                ),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          );
        }),
      ),
    );
  }
}
