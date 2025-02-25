import 'package:crypto_questor/product/components/styles/project_custom_colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: ProjectCustomColors.bgColor,
  ),
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
  primaryColor: ProjectCustomColors.bgColor,
  secondaryHeaderColor: Colors.white,
  appBarTheme: const AppBarTheme(
      backgroundColor: ProjectCustomColors.mYellow,
    iconTheme: IconThemeData(
      color: ProjectCustomColors.bgColor,
    ),
  ),
  colorScheme: ColorScheme.dark(
    surface: ProjectCustomColors.bgColor,
    primary: ProjectCustomColors.bgColor,
    secondary: ProjectCustomColors.coinsCardColor.withOpacity(0.5),
  ),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFFF4F1F1),
  ),
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
  primaryColor: const Color(0xFFF4F1F1),
  secondaryHeaderColor: ProjectCustomColors.bgColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: ProjectCustomColors.bgColor,
    secondary: const Color(0xFFF5F5F5).withOpacity(0.9),
  ),
);