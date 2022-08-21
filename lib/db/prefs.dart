import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class PrefsDBService {
  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('name');
    return action == null;
  }

  static saveCRData({
    required String name,
    required String batchCode,
    required String deptCode,
    required String section,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('batchCode', batchCode);
    prefs.setString('departmentCode', deptCode);
    prefs.setString('section', section);
  }
}
