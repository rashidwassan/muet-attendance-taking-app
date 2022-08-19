import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/constants/images.dart';
import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  static const String routeName = '/report-page';
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
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
              Image.asset(
                (absenteeCount == 0) ? Images.smiley : Images.disappointed,
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
                          height: 16,
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
                height: 32,
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
            ],
          ),
        ),
      ),
    );
  }
}
