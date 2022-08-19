import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2000), () {
      Navigator.pushNamed(context, SplashScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
