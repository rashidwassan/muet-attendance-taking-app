import 'package:flutter/material.dart';

class StudentListProvider with ChangeNotifier {
  int _currentStudent = 0;
  final List<String> _allStudents = [
    '19SW01',
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
  ];

  // integers for storing the indices of absentees
  final List<int> _presentStudents = [];
  final List<int> _absentStudents = [];

  int get currentStudent => _currentStudent;
  List<String> get allStudents => _allStudents;
  List<int> get presentStudents => _presentStudents;
  List<int> get absentStudents => _absentStudents;

  void addToPresentsList() {
    if (currentStudent == allStudents.length - 1) return;
    _presentStudents.add(currentStudent);
    print(_presentStudents.length);
    _currentStudent++;
    notifyListeners();
  }

  void addToAbsenteesList() {
    if (currentStudent == allStudents.length - 1) return;
    _absentStudents.add(currentStudent);
    _currentStudent++;
    notifyListeners();
  }

  String getRollsOfAbsentees() {
    String rollNumbers = '';
    for (int i = 0; i < _absentStudents.length; i++) {
      rollNumbers += _allStudents[_absentStudents[i]] + ', ';
    }
    return rollNumbers;
  }
}
