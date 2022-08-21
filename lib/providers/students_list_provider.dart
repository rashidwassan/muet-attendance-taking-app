import 'package:attendance_app/models/student.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentListProvider with ChangeNotifier {
  int _currentStudent = 0;
  bool _ifGetAbsenteesList = true;
  List<Student> _allStudents = [];

  // integers for storing the indices of absentees
  List<int> _presentStudents = [];
  List<int> _absentStudents = [];

  int get currentStudent => _currentStudent;
  List<Student> get allStudents => _allStudents;
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
      rollNumbers += '${_allStudents[desiredList[i]].rollNumber}, ';
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

  saveStudentDataToDB(Student student) async {
    var box = await Hive.openBox<Student>('studentsRecord');
    box.add(student);
    notifyListeners();
  }

  loadStudentRecord() async {
    final box = await Hive.openBox<Student>('studentsRecord');

    _allStudents = box.values.toList();

    notifyListeners();
  }
}
