import 'package:attendance_app/components/main_button.dart';
import 'package:attendance_app/components/textfields.dart';
import 'package:attendance_app/db/prefs.dart';
import 'package:attendance_app/screens/attendance_page.dart';
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
  final FocusNode _nameFieldFocusNode = FocusNode();
  final FocusNode _batchFieldFocusNode = FocusNode();
  final FocusNode _deptFieldFocusNode = FocusNode();
  final FocusNode _sectionFieldFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _batchCodeController.dispose();
    _deptCodeController.dispose();
    _sectionCodeController.dispose();

    _nameFieldFocusNode.dispose();
    _batchFieldFocusNode.dispose();
    _deptFieldFocusNode.dispose();
    _sectionFieldFocusNode.dispose();
  }

  void saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      PrefsDBService.saveCRData(
        name: _nameController.text.trim(),
        batchCode: _batchCodeController.text,
        deptCode: _deptCodeController.text.toUpperCase(),
        section: _sectionCodeController.text.toUpperCase(),
      );
      Navigator.pushReplacementNamed(context, AttendancePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('Welcome ${_nameController.text}!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: Image.asset(
                //     Images.welcome,
                //     width: 100,
                //   ),
                // ),
                const SizedBox(
                  height: 16,
                ),
                AttendanceAppTextField(
                  batchCodeController: _nameController,
                  focusNode: _nameFieldFocusNode,
                  hintText: '',
                  title: 'Please enter your name:',
                  label: 'Your Name',
                  textInputType: TextInputType.name,
                  onChanged: (v) {
                    setState(() {});
                  },
                  onSubmitted: (v) {
                    _batchFieldFocusNode.requestFocus();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AttendanceAppTextField(
                  batchCodeController: _batchCodeController,
                  focusNode: _batchFieldFocusNode,
                  hintText: 'i.e 19',
                  title: 'Please enter your batch code:',
                  label: 'Batch Number',
                  textInputType: TextInputType.number,
                  onChanged: (v) {
                    setState(() {});
                  },
                  onSubmitted: (v) {
                    _deptFieldFocusNode.requestFocus();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: AttendanceAppTextField(
                    batchCodeController: _deptCodeController,
                    focusNode: _deptFieldFocusNode,
                    hintText: 'i.e SW',
                    title: 'Please enter your department code:',
                    label: 'Department Code',
                    onChanged: (v) {
                      setState(() {});
                    },
                    onSubmitted: (v) {
                      _sectionFieldFocusNode.requestFocus();
                    },
                  ),
                ),
                AttendanceAppTextField(
                  batchCodeController: _sectionCodeController,
                  focusNode: _sectionFieldFocusNode,
                  hintText: 'i.e 01/A',
                  title: 'Please enter your Section:',
                  label: 'Section',
                  onChanged: (v) {
                    setState(() {});
                  },
                  onSubmitted: (v) {},
                ),
                const SizedBox(
                  height: 32,
                ),
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
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 50,
                  child: MainButton(
                    buttonText: 'Save & Continue',
                    onPressed: saveAndContinue,
                    buttonColor: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
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
      ),
    );
  }
}
