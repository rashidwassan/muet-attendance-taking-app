import 'package:attendance_app/components/main_button.dart';
import 'package:flutter/material.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(children: [
          SizedBox(
            height: 50,
            child: MainButton(
              buttonText: '+ ADD Student',
              textColor: Colors.white,
              onPressed: () {},
              buttonColor: Colors.green.shade400,
            ),
          ),
        ]),
      ),
    );
  }
}
