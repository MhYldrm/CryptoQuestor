import 'package:flutter/material.dart';

/// A utility class for storing custom color constants used throughout the app.
/// This class ensures consistent color usage across the app and centralizes color management.
/// Colors are defined as static constants and can be accessed globally wherever needed.
///
/// ### Key Responsibilities:
/// - Centralizes color definitions to promote consistency across the application.
/// - Ensures all color definitions are easily accessible and reusable across different widgets.
/// - Defines a set of colors that are suitable for various UI components such as backgrounds, text,
///   buttons, and other UI elements.
///
/// ### Color Definitions:
/// - [bgColor] Navy Blue background color of the app. This color is used for the overall background.
/// - [mYellow] Primary yellow color used for highlights or buttons.
/// - [mPurple] Primary purple color, often used for titles, text, and accent elements.
/// - [mWhitePrimary] Standard white color used for text, backgrounds, and UI elements.
/// - [mBlackPrimary] Standard black color used for text and primary UI elements.
/// - [mGreyPrimary] Neutral grey color, typically used for inactive or secondary elements.
/// - [mRedPrimary] Bright red color, often used for error messages and warnings.
/// - [mLightPurple] Lighter purple color used for accent elements and backgrounds.
/// - [mLilacPrimary] Soft lilac color, used for subtle highlights and accents.
/// - [mGreenPrimary] Green color, typically used for success indicators and positive actions.
/// - [mPinkPrimary] Soft pink color, used for secondary highlights or decorative elements.
/// - [mLightYellow] Light yellow color, used for secondary highlights and soft accents.
/// - [mLightGrey] Lighter grey with a hint of blue, used for text or background elements.
/// - [coinsCardColor] Dark blue color, used for the coins card background.
/// - [earnCardGradientColors] Gradient colors used for decorative card backgrounds with a fading effect.
/// - [creditCardGradientLightThemeColors] Gradient colors used for credit card backgrounds in light theme.
/// - [creditCardGradientDarkThemeColors] Gradient colors used for credit card backgrounds in dark theme.
/// - [earnCardGradientLightThemeColors] Gradient colors used for earn cards background in light theme.
///

final class ProjectCustomColors {
  const ProjectCustomColors._();

  static const Color bgColor = Color(0xff001E34);
  static const Color mYellow = Color(0xffffd400);
  static const Color mPurple = Color(0xff311B92);
  static const Color mWhitePrimary = Colors.white;
  static const Color mBlackPrimary = Colors.black;
  static const Color mGreyPrimary = Colors.grey;
  static const Color mRedPrimary = Colors.red;
  static const Color mLightPurple = Colors.deepPurpleAccent;
  static const Color mLilacPrimary = Color(0xffD4BBFF);
  static const Color mGreenPrimary = Colors.green;
  static const Color mPinkPrimary = Colors.pink;
  static const Color mLightYellow = Color.fromARGB(255, 135, 116, 25);
  static const Color mLightGrey = Color.fromARGB(255, 6, 43, 69);
  static const Color coinsCardColor = Color(0xff0B255B);
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
