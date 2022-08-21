import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class PrefsDBService {
  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('username');
    return action == null;
  }

  static Future<bool> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('username');
    return action == null;
  }
}
