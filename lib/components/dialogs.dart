import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/components/textfields.dart';
import 'package:attendance_app/constants/strings.dart';
import 'package:attendance_app/models/student.dart';
import 'package:attendance_app/providers/user_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/students_list_provider.dart';

dynamic showRetakeConfirmationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(24.0),
      child: Material(
        elevation: 40,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    'Are you sure you want to retake the attendance? All current data will be lost.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                MainButton(
                  buttonText: 'RESET',
                  onPressed: () {
                    Provider.of<StudentListProvider>(
                      context,
                      listen: false,
                    ).retakeAttendance();
                    Navigator.pop(context);
                  },
                  buttonColor: Colors.red.shade200,
                ),
                const SizedBox(
                  height: 12,
                ),
                MainButton(
                  buttonText: 'DISMISS',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  buttonColor: Colors.teal.shade200,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

dynamic showStudentDataInputDialog(
  BuildContext context, {
  Student? student,
  int? indexForUpdation,
}) {
  showDialog(
    context: context,
    builder: (context) {
      // importing _userData to extract batch and department code.
      final List<String> userData =
          Provider.of<UserDataProvider>(context, listen: false).userData ?? [];
      final TextEditingController studentNameController =
          TextEditingController();
      final TextEditingController rollNumberController =
          TextEditingController(text: userData[1] + userData[2]);

      if (student != null) {
        studentNameController.text = student.name;
        rollNumberController.text = student.rollNumber;
      }

      final formKey = GlobalKey<FormState>();
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Material(
          elevation: 40,
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Add New Student',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    AttendanceAppTextField(
                      batchCodeController: studentNameController,
                      hintText: 'Student Name',
                      label: '',
                      title: "Enter student's name:",
                      onChanged: (v) {},
                      onSubmitted: (v) {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AttendanceAppTextField(
                      batchCodeController: rollNumberController,
                      hintText: '',
                      label: '',
                      title: "Enter student's roll number:",
                      onChanged: (v) {},
                      onSubmitted: (v) {},
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 55,
                      child: MainButton(
                        buttonText: student == null ? 'ADD' : 'UPDATE',
                        textColor: Colors.white,
                        onPressed: () {
                          if (student != null) {
                            if (studentNameController.text == student.name &&
                                rollNumberController.text == student.rollNumber)
                              return;
                          }
                          if (formKey.currentState!.validate()) {
                            final Student newStudent = Student(
                              name: studentNameController.text,
                              rollNumber: rollNumberController.text,
                            );
                            if (student != null && indexForUpdation != null) {
                              Provider.of<StudentListProvider>(
                                context,
                                listen: false,
                              ).updateStudentDataInDB(
                                newStudent,
                                boxName: 'studentsRecord',
                                index: indexForUpdation,
                              );
                            } else {
                              Provider.of<StudentListProvider>(
                                context,
                                listen: false,
                              ).saveStudentDataToDB(
                                newStudent,
                                boxName: StringConstants.studentDBName,
                              );
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${studentNameController.text} (${rollNumberController.text}) was added to the database.',
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        buttonColor: Colors.red.shade200,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 55,
                      child: MainButton(
                        buttonText: 'DISMISS',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        buttonColor: Colors.teal.shade200,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

// Future<bool> delete(
//   BuildContext context, {
//   required Student student,
// }) {
//   return showCupertinoDialog(
    
//     context: context,
//     builder: (BuildContext ctx) {
//       return CupertinoAlertDialog(
//         title: const Text('Please Confirm'),
//         content: Text('Are you sure to remove ${student.rollNumber}?'),
//         actions: [
//           CupertinoDialogAction(
//             onPressed: () {
//               Navigator.pop(context, true);
//             },
//             isDefaultAction: true,
//             isDestructiveAction: true,
//             child: const Text('Yes'),
//           ),
//           CupertinoDialogAction(
//             onPressed: () {
//               Navigator.pop(context, true);
//             },
//             child: const Text('No'),
//           )
//         ],
//       );
//     },
//   );
// }
