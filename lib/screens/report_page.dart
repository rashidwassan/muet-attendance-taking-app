import 'package:attendance_app/components/main_button.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  static const String routeName = '/report-page';
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String header = '19SW-1\n';
  @override
  Widget build(BuildContext context) {
    final String report = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SelectableText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: header + report,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
                  buttonText: 'COPY',
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
