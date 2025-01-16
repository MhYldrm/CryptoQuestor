import 'package:flutter/material.dart';
import '../styles/custom_colors.dart';

/// A utility class that provides pre-defined box decorations used across the project.
///
/// This class contains static getter methods that return [BoxDecoration] objects
/// with commonly used styles for different screens (e.g., profile, earnings, sign-up).
/// These decorations ensure consistency in the UI design.

final class ProjectBoxDecorations {
  const ProjectBoxDecorations._();

  static BoxDecoration get profilePageDarkThemeBoxDecoration {
    return const BoxDecoration(
      shape: BoxShape.rectangle, // Rectangle shape for the box.
      color: CustomColors.bgcolor, // Custom background color from CustomColors.
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), // Rounded top-left corner.
        topRight: Radius.circular(20), // Rounded top-right corner.
      ),
    );
  }

  static BoxDecoration get profilePageLightThemeBoxDecoration {
    return const BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), // Rounded top-left corner.
        topRight: Radius.circular(20), // Rounded top-right corner.
      ),
    );
  }

  static BoxDecoration get earnDetailsPageBoxDecoration {
    return BoxDecoration(
      shape: BoxShape.rectangle, // Rectangle shape for the box.
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15), // Rounded top-left corner.
        topRight: Radius.circular(15), // Rounded top-right corner.
      ),
      color:
          Colors.transparent.withOpacity(0.5), // Semi-transparent background.
    );
  }

  static BoxDecoration get signPagesBoxDecoration {
    return BoxDecoration(
      color: CustomColors.mYellow, // Yellow background color from CustomColors.
      shape: BoxShape.rectangle, // Rectangle shape for the box.
      borderRadius: BorderRadius.circular(5), // Slightly rounded corners.
      border: Border.all(
        color: CustomColors
            .mYellow, // Border color is the same yellow as the background.
      ),
    );
  }

  static BoxDecoration get addPortfolioPagesBoxDarkThemeDecoration {
    return BoxDecoration(
      color: CustomColors.mLightGrey,
      borderRadius: BorderRadius.circular(12),
    );
  }

  static BoxDecoration get addPortfolioPagesLightThemeBoxDecoration {
    return BoxDecoration(
      color: CustomColors.mGreyPrimary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
