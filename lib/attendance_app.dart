import 'package:attendance_app/providers/students_list_provider.dart';
import 'package:attendance_app/providers/user_data_provider.dart';
import 'package:attendance_app/screens/attendance_page.dart';
import 'package:attendance_app/screens/batch_section_input_page.dart';
import 'package:attendance_app/screens/csv_import_screen.dart';
import 'package:attendance_app/screens/report_page.dart';
import 'package:attendance_app/screens/splash_screen.dart';
import 'package:attendance_app/screens/students_record_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MUETAttendanceApp extends StatelessWidget {
  const MUETAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<StudentListProvider>(
          create: (_) => StudentListProvider(),
        ),
        ListenableProvider<UserDataProvider>(create: (_) => UserDataProvider()),
      ],
      child: MaterialApp(
        title: 'Attendance App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade900,
            centerTitle: true,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white60, size: 20),
          ),
          scaffoldBackgroundColor: Colors.grey.shade900,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          AttendancePage.routeName: (context) => const AttendancePage(),
          ReportPage.routeName: (context) => const ReportPage(),
          StudentsRecordPage.routeName: (context) => const StudentsRecordPage(),
          BatchAndSectionSpecificationScreen.routeName: (context) =>
              const BatchAndSectionSpecificationScreen(),
          CSVDataEntryScreen.routeName: (context) => CSVDataEntryScreen(),
        },
      ),
    );
  }
}
