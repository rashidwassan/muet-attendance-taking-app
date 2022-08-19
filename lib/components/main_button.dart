import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
  });

  final String buttonText;
  final Function() onPressed;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0,
      highlightElevation: 0,
      height: 75,
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
