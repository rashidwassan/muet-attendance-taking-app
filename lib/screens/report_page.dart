import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  static const String routeName = '/report-page';
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String header = '19SW-1';
  @override
  Widget build(BuildContext context) {
    String? report = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(text: report),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
