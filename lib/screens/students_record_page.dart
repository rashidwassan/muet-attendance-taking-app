import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            LottieBuilder.asset(Images.sadAnim),
            const Text(
              'No students found in the record. Please tap that green button to start adding students.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 48,
            ),
            SizedBox(
              height: 50,
              child: MainButton(
                buttonText: '+ ADD Student',
                textColor: Colors.white,
                onPressed: () {},
                buttonColor: Colors.green.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
