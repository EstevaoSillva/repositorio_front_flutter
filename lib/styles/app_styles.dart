import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFF007BFF);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color textColor = Color(0xFF333333);
  static const Color warningColor = Colors.orange;
  static const Color dangerColor = Colors.red;
  static const Color successColor = Colors.green;

  static final TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static final TextStyle odometerText = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static final BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        spreadRadius: 2,
      ),
    ],
  );
}
