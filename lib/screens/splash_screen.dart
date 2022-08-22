import 'package:attendance_app/db/prefs.dart';
import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:attendance_app/providers/user_data_provider.dart';
import 'package:attendance_app/screens/attendance_page.dart';
import 'package:attendance_app/screens/batch_section_input_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
    Future.delayed(const Duration(seconds: 2), () {
      navigate();
    });
  }

  void loadData() async {
    Provider.of<UserDataProvider>(context, listen: false).userData =
        await PrefsDBService.getUserInfo();
    // ignore: use_build_context_synchronously
    Provider.of<StudentListProvider>(context, listen: false)
        .loadStudentRecord();
  }

  // ignore: avoid_void_async
  void navigate() async {
    if (await PrefsDBService.isFirstRun()) {
      Navigator.pushReplacementNamed(
          context, BatchAndSectionSpecificationScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, AttendancePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade900,
              Colors.black38,
              Colors.grey.shade900
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                curve: Curves.bounceInOut,
                duration: const Duration(milliseconds: 800),
                tween: Tween<double>(
                  begin: 0.01,
                  end: 0.45,
                ),
                builder: (context, double val, child) => Container(
                  width: size.width * val,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(4, 4))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/muet.png',
                              width: size.width * val,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'MUET CRs Attendance System\nDeveloped By: Rashid Wassan',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
