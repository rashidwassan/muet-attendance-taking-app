import 'package:flutter/material.dart';

class BatchAndSectionSpecificationScreen extends StatefulWidget {
  const BatchAndSectionSpecificationScreen({super.key});

  @override
  State<BatchAndSectionSpecificationScreen> createState() =>
      _BatchAndSectionSpecificationScreenState();
}

class _BatchAndSectionSpecificationScreenState
    extends State<BatchAndSectionSpecificationScreen> {
  final TextEditingController _batchCodeController = TextEditingController();
  final TextEditingController _deptCodeController = TextEditingController();
  final TextEditingController _sectionCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _batchCodeController,
            ),
          ],
        ),
      ),
    );
  }
}
