import 'package:flutter/material.dart';

class UserDataProvider with ChangeNotifier {
  List<String>? data;

  set userData(List<String>? newData) {
    data = newData;
    notifyListeners();
  }

  List<String>? get userData => data;
}
