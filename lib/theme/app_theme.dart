 import 'package:flutter/material.dart';

class AppTheme {

  static final Color primaryColor = Colors.indigo;
  static final Color colorText = Colors.white;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: primaryColor,
      foregroundColor: colorText,
      centerTitle: true
    )
  );

 }