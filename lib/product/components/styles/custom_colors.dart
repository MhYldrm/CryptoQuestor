import 'package:flutter/material.dart';

/// A utility class for storing custom color constants used throughout the app.
/// This class ensures consistent color usage across the app and centralizes color management.
///
final class CustomColors {
  const CustomColors._();

  /// Navy Blue background color of the app. This color is used for the overall background.
  static const Color bgcolor = Color(0xff001E34);

  /// [mYellow] Primary yellow color.
  static const Color mYellow = Color(0xffffd400);

  /// [mPurple] Primary purple color, often used for titles, text, and accent elements.
  static const Color mPurple = Color(0xff311B92);

  /// [mWhitePrimary] Standard white color used for text, backgrounds, and UI elements.
  static const Color mWhitePrimary = Colors.white;

  /// [mBlackPrimary] Standard black color used for text and primary UI elements.
  static const Color mBlackPrimary = Colors.black;

  /// [mGreyPrimary] Neutral grey color, typically used for inactive or secondary elements.
  static const Color mGreyPrimary = Colors.grey;

  /// [mRedPrimary] Bright red color, often used for error messages and warnings.
  static const Color mRedPrimary = Colors.red;

  /// [mLightPurple] Lighter purple color used for accent elements and backgrounds.
  static const Color mLightPurple = Colors.deepPurpleAccent;

  /// [mLilacPrimary] Soft lilac color, used for subtle highlights and accents.
  static const Color mLilacPrimary = Color(0xffD4BBFF);

  /// [mGreenPrimary] Green color, typically used for success indicators and positive actions.
  static const Color mGreenPrimary = Colors.green;

  /// [mPinkPrimary] Soft pink color, used for secondary highlights or decorative elements.
  static const Color mPinkPrimary = Colors.pink;

  /// [mLightYellow] Light yellow color, used for secondary highlights and soft accents.
  static const Color mLightYellow = Color.fromARGB(255, 135, 116, 25);

  /// [mLightGrey] Lighter grey with a hint of blue, used for text or background elements.
  static const Color mLightGrey = Color.fromARGB(255, 6, 43, 69);

  /// [coinsCardColor] Dark blue color, used for the coins card background.
  static const Color coinsCardColor = Color(0xff0B255B);

  /// [earnCardGradientColors] Gradient colors used for decorative card backgrounds with a fading effect.
  static const List<Color> earnCardGradientColors = [
    Color(0x99FFFFFF),
    Color(0x00FFFFFF),
    Color(0x00FFFFFF),
    Color(0x99FFFFFF),
  ];

  static const List<Color> creditCardGradientLightThemeColors = [
    Color(0xFFF5F5F5),
    Color(0xFFB3B6B5),
    Color(0xFFF5F5F5),
    Color(0xFFF5F5F5),
    Color(0xFFF5F5F5),
  ];

  static const List<Color> creditCardGradientDarkThemeColors = [
    Color.fromARGB(255, 5, 8, 28), // Darker blue gradient
    Color.fromARGB(255, 17, 53, 87),
  ];

  static const List<Color> earnCardGradientLightThemeColors = [
    Color(0xFFB3B6B5),
    Color(0xFFF5F5F5),
    Color(0xFFB3B6B5),
  ];
}
