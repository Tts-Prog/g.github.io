// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        // side: BorderSide(color: borderColor),
      )),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        return Colors.white;
      }),
      textStyle: MaterialStateProperty.resolveWith((states) {
        return const TextStyle(
            fontFamily: AppFonts.lato,
            fontWeight: FontWeight.w600,
            fontSize: 14);
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        } else {
          return AppColors.ameSplashScreenBgColor;
        }
      }),
      elevation: MaterialStateProperty.resolveWith((states) => 0),
      minimumSize: MaterialStateProperty.resolveWith(
          (states) => const Size(double.infinity, 56)),
    )),
    fontFamily: AppFonts.lato,
    textTheme: const TextTheme(
        displaySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        displayMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: AppColors.typographyTitle),
        bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.typographyTitle),
        titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.typographyTitle),
        titleMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.typographyTitle
            // fontFamily: AppFonts.alatsi
            ),
        headlineMedium: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            color: AppColors.typographyTitle)),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      // filled: true,
      hintStyle: const TextStyle(
          fontFamily: AppFonts.lato,
          color: AppColors.typographySubColor,
          fontSize: 14,
          fontWeight: FontWeight.w900),
      floatingLabelStyle: const TextStyle(
          // textBaseline: TextBaseline.ideographic,
          color: AppColors.typographyTitle,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.18,
          height: 0),
      contentPadding: const EdgeInsets.only(left: 10, right: 5),
      labelStyle: const TextStyle(
          color: AppColors.textFdBorder,
          fontSize: 14,
          fontWeight: FontWeight.w400),
      // focusedErrorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: const BorderSide(width: 1, color: AppColors.red400),
      // ),
      // errorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: const BorderSide(width: 1, color: AppColors.red400),
      // ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(width: 1, color: AppColors.ameSplashScreenBgColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: AppColors.textFdBorder),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1, color: AppColors.textFdBorder),
      ),
    ),
  );
}

class AppFonts {
  static const String lato = "Lato";
  static const String alatsi = "Alatsi";
}
