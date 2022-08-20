import 'dart:io';

import 'package:attendance_app/attendance_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory directory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(const MUETAttendanceApp());
}
