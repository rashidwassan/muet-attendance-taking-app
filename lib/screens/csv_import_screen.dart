import 'dart:convert';
import 'dart:io';

import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/constants/strings.dart';
import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';

class CSVDataEntryScreen extends StatefulWidget {
  static const String routeName = '/csv-data-entry';
  @override
  State<StatefulWidget> createState() {
    return CSVDataEntryScreenState();
  }
}

class CSVDataEntryScreenState extends State<CSVDataEntryScreen> {
  late List<List<dynamic>> studentData;
  List<PlatformFile>? _paths;
  final String _extension = "csv";
  final FileType _pickingType = FileType.custom;
  bool isCSVLoaded = false;
  @override
  void initState() {
    super.initState();
    studentData = List<List<dynamic>>.empty(growable: true);
  }

  openFile(filepath) async {
    final File f = File(filepath.toString());
    final input = f.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    setState(() {
      studentData = fields;
      isCSVLoaded = true;
    });
  }

  void _openFileExplorer() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowedExtensions: (_extension.isNotEmpty)
            ? _extension.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      try {
        openFile(_paths![0].path);
      } catch (e) {
        Navigator.of(context).pushNamed(CSVDataEntryScreen.routeName);
      }
    });
  }

  void _saveRecordsToDatabase() {
    for (int i = 0; i < studentData.length; i++) {
      Provider.of<StudentListProvider>(context).saveStudentDataToDB(
        Student(
          name: studentData[i][1].toString(),
          rollNumber: studentData[i][0].toString(),
        ),
        boxName: StringConstants.studentDBName,
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text("CSV Data Entry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: studentData.isEmpty
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (studentData.isEmpty)
              const SizedBox()
            else
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: studentData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(studentData[index][0].toString()),
                            Text(studentData[index][1].toString()),
                            Text(studentData[index][2].toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 45,
                    child: MainButton(
                      onPressed: isCSVLoaded
                          ? _saveRecordsToDatabase
                          : _openFileExplorer,
                      buttonColor: Colors.green.shade100,
                      buttonText: isCSVLoaded
                          ? "Add All to Database"
                          : "Import CSV File",
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Please make sure your CSV file contains roll numbers in first column and names in second.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
