import 'package:attendance_app/screens/attendance_page.dart';
import 'package:attendance_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class MUETAttendanceApp extends StatelessWidget {
  const MUETAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        AttendancePage.routeName: (context) => const AttendancePage(),
      },
    );
  }
}
