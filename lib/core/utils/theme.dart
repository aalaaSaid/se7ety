import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_style.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: AppColors.white,
    snackBarTheme: const SnackBarThemeData(backgroundColor: AppColors.redColor),
    scrollbarTheme: const ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(AppColors.primaryColor),
        // trackColor: MaterialStatePropertyAll(AppColors.color2),
        // trackVisibility: const MaterialStatePropertyAll(true),
        radius: Radius.circular(20)),
    appBarTheme: AppBarTheme(
        titleTextStyle: getTitleStyle(color: AppColors.white),
        centerTitle: true,
        elevation: 0.0,
        actionsIconTheme: const IconThemeData(color: AppColors.primaryColor),
        backgroundColor: AppColors.primaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide.none,
      ),
      filled: true,
      suffixIconColor: AppColors.primaryColor,
      prefixIconColor: AppColors.primaryColor,
      fillColor: AppColors.accentColor,
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.grey,
      indent: 10,
      endIndent: 10,
    ),
  );
}
