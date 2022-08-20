import 'package:flutter/material.dart';

class StudentListProvider with ChangeNotifier {
  int _currentStudent = 0;
  bool _ifGetAbsenteesList = true;
  final List<String> _allStudents = [
    'F16 - 19SSW11',
    '19SW03',
    '19SW07',
    '19SW11',
    '19SW13',
    '19SW17',
    '19SW19',
    '19SW25',
    '19SW27',
    '19SW33',
    '19SW45',
    '19SW55',
    '19SW57',
    '19SW59',
    '19SW101',
    '19SW103',
    '19SW105',
    '19SW107',
    'All Done!'
  ];

  // integers for storing the indices of absentees
  List<int> _presentStudents = [];
  List<int> _absentStudents = [];

  int get currentStudent => _currentStudent;
  List<String> get allStudents => _allStudents;
  List<int> get presentStudents => _presentStudents;
  List<int> get absentStudents => _absentStudents;

  List<int> get desiredStudents =>
      _ifGetAbsenteesList ? _absentStudents : _presentStudents;

  void addToPresentsList() {
    if (currentStudent == allStudents.length - 1) return;
    _presentStudents.add(currentStudent);
    _currentStudent++;
    notifyListeners();
  }

  void addToAbsenteesList() {
    if (currentStudent == allStudents.length - 1) return;
    _absentStudents.add(currentStudent);
    _currentStudent++;
    notifyListeners();
  }

  String getRollsFromDesiredList() {
    final List<int> desiredList =
        _ifGetAbsenteesList ? _absentStudents : _presentStudents;
    String rollNumbers = '';
    for (int i = 0; i < desiredList.length; i++) {
      // ignore: use_string_buffers
      rollNumbers += '${_allStudents[desiredList[i]]}, ';
    }
    return rollNumbers;
  }

  void retakeAttendance() {
    _currentStudent = 0;
    _absentStudents = [];
    _presentStudents = [];
    notifyListeners();
  }

  bool get ifGetAbsenteesList => _ifGetAbsenteesList;

  set ifGetAbsenteesList(bool newVal) {
    _ifGetAbsenteesList = newVal;
    notifyListeners();
  }
}
