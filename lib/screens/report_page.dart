import 'dart:io';
import 'dart:typed_data';

import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/constants/images.dart';
import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class ReportPage extends StatefulWidget {
  static const String routeName = '/report-page';
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late Uint8List _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final int absenteeCount =
        Provider.of<StudentListProvider>(context).absentStudents.length;
    const String header = '19SW-1';
    final String date = DateFormat.yMMMEd().format(DateTime.now());
    final String report = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: const Text('Attendance Report'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                controller: screenshotController,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Image.asset(
                      (absenteeCount == 0)
                          ? Images.smiley
                          : Images.disappointed,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      (absenteeCount == 0)
                          ? 'All Students Present!'
                          : '$absenteeCount students absent today!',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Column(
                            children: [
                              const Text(
                                header,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                Provider.of<StudentListProvider>(context)
                                        .ifGetAbsenteesList
                                    ? 'LIST OF ABSENT STUDENTS'
                                    : 'LIST OF PRESENT STUDENTS',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Provider.of<StudentListProvider>(context)
                                              .ifGetAbsenteesList
                                          ? Colors.red.shade400
                                          : Colors.green,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SelectableText.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: report,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 50,
                child: MainButton(
                  buttonText: 'Copy Text',
                  onPressed: () {
                    FlutterClipboard.copy(report).then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Text Copied to clipboard!'),
                        ),
                      ),
                    );
                  },
                  buttonColor: Colors.blue.shade200,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'OR',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              SizedBox(
                height: 50,
                child: MainButton(
                  buttonText: 'Take a Screenshot',
                  onPressed: () async {
                    await screenshotController
                        .capture(delay: const Duration(milliseconds: 10))
                        .then((Uint8List? image) async {
                      if (image != null) {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.path}/image.png').create();
                        await imagePath.writeAsBytes(image);

                        /// Share Plugin
                        await Share.shareFiles([imagePath.path]);
                      }
                    });
                  },
                  buttonColor: Colors.green.shade200,
                ),
              ),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
