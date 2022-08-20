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
      body: Column(children: []),
    );
  }
}
