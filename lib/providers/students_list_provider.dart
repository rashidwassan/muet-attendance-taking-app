import 'package:flutter/material.dart';

class StudentListProvider with ChangeNotifier {
  List<String> allStudents = [
    '19SW01',
    '19SW03',
    '19SW07',
    '19SW011',
  ];

  // integers for storing the indices of absentees
  List<int> absentStudents = [];
  List<int> presentStudents = [];

  void addToAbsenteesList(int index) {
    absentStudents.add(index);
    notifyListeners();
  }

  void addToPresentsList(int index) {
    presentStudents.add(index);
    notifyListeners();
  }
}
