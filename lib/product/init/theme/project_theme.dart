import 'package:crypto_questor/product/components/styles/custom_colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: CustomColors.bgcolor,
  ),
  primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
  primaryColor: CustomColors.bgcolor,
  secondaryHeaderColor: Colors.white,
  appBarTheme: const AppBarTheme(
      backgroundColor: CustomColors.mYellow,
    iconTheme: IconThemeData(
      color: CustomColors.bgcolor,
    ),
  ),
  colorScheme: ColorScheme.dark(
    surface: CustomColors.bgcolor,
    primary: CustomColors.bgcolor,
    secondary: CustomColors.coinsCardColor.withOpacity(0.5),
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
  secondaryHeaderColor: CustomColors.bgcolor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: CustomColors.bgcolor,
    secondary: const Color(0xFFF5F5F5).withOpacity(0.9),
  ),
);