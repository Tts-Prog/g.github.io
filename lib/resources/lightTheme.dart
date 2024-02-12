import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  elevatedButtonTheme:ElevatedButtonThemeData(style: ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      // side: BorderSide(color: borderColor),
    )),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      return Colors.white;
    }),
    textStyle: MaterialStateProperty.resolveWith((states) {
      return const TextStyle(fontWeight: FontWeight.w600, fontSize: 14);
    }),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey;
      } else {
        return Colors.white;
      }
    }),
    elevation: MaterialStateProperty.resolveWith((states) => 0),
    minimumSize: MaterialStateProperty.resolveWith((states) => const Size(double.infinity, 56)),
  ))
);