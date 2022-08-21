import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/components/textfields.dart';
import 'package:attendance_app/constants/images.dart';
import 'package:flutter/material.dart';

class BatchAndSectionSpecificationScreen extends StatefulWidget {
  static const String routeName = '/batch-section-specification-page';
  const BatchAndSectionSpecificationScreen({super.key});

  @override
  State<BatchAndSectionSpecificationScreen> createState() =>
      _BatchAndSectionSpecificationScreenState();
}

class _BatchAndSectionSpecificationScreenState
    extends State<BatchAndSectionSpecificationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _batchCodeController = TextEditingController();
  final TextEditingController _deptCodeController = TextEditingController();
  final TextEditingController _sectionCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _batchCodeController.dispose();
    _deptCodeController.dispose();
    _sectionCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  Images.welcome,
                  width: 100,
                ),
              ),
              const Spacer(),
              const SizedBox(
                height: 16,
              ),
              AttendanceAppTextField(
                batchCodeController: _batchCodeController,
                hintText: '',
                title: 'Please enter your name:',
                label: 'Your Name',
                onChanged: (v) {},
              ),
              const SizedBox(
                height: 24,
              ),
              AttendanceAppTextField(
                batchCodeController: _batchCodeController,
                hintText: 'i.e 19',
                title: 'Please enter your batch code:',
                label: 'Batch Number',
                onChanged: (v) {
                  setState(() {});
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: AttendanceAppTextField(
                  batchCodeController: _deptCodeController,
                  hintText: 'i.e SW',
                  title: 'Please enter your department code:',
                  label: 'Department Code',
                  onChanged: (v) {
                    setState(() {});
                  },
                ),
              ),
              AttendanceAppTextField(
                batchCodeController: _sectionCodeController,
                hintText: 'i.e 01/A',
                title: 'Please enter your Section:',
                label: 'Section',
                onChanged: (v) {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 32,
              ),
              const Spacer(),
              const Center(
                  child: Text(
                'The section text in report:',
                style: TextStyle(color: Colors.white70),
              )),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${_batchCodeController.text}${_deptCodeController.text.toUpperCase()} - ${_sectionCodeController.text.toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                child: MainButton(
                  buttonText: 'Save & Continue',
                  onPressed: () {},
                  buttonColor: Colors.green,
                ),
              ),
              const Spacer(),
              const Center(
                child: Text(
                  "Please make sure to double check the data, this will be included in reports that you generate!\nDon't worry, this a one time setup.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
