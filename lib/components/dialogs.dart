import 'package:attendance_app/components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/students_list_provider.dart';

dynamic showRetakeConfirmationDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Material(
              elevation: 40,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          'Are you sure you want to reset the progress? All current data will be lost.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      MainButton(
                        buttonText: 'RESET',
                        onPressed: () {
                          Provider.of<StudentListProvider>(
                            context,
                            listen: false,
                          ).retakeAttendance();
                          Navigator.pop(context);
                        },
                        buttonColor: Colors.red.shade200,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MainButton(
                        buttonText: 'DISMISS',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        buttonColor: Colors.teal.shade200,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
}
