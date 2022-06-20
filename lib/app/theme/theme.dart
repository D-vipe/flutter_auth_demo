import 'package:flutter/material.dart';
import 'package:flutter_demo_auth/app/constants/app_colors.dart';

class AppTheme {
  static ThemeData baseTheme() => ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backGround,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Manrope')));
}
