import 'package:flutter/material.dart';
import '../styles/project_custom_colors.dart';

/// A utility class that provides pre-defined box decorations used across the project.
///
/// This class contains static getter methods that return [BoxDecoration] objects
/// with commonly used styles for different screens (e.g., profile, earnings, sign-up).
/// These decorations ensure consistency in the UI design.

final class ProjectBoxDecorations {
  const ProjectBoxDecorations._();

  /// Box decoration for the profile page in dark theme.
  ///
  /// - **Returns**: A [BoxDecoration] with a custom background color and rounded top corners.
  static BoxDecoration get profilePageDarkThemeBoxDecoration {
    return const BoxDecoration(
      color: ProjectCustomColors
          .bgColor, // Custom background color from CustomColors.
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), // Rounded top-left corner.
        topRight: Radius.circular(20), // Rounded top-right corner.
      ),
    );
  }

  /// Box decoration for the profile page in light theme.
  ///
  /// - **Returns**: A [BoxDecoration] with a white background and rounded top corners.
  static BoxDecoration get profilePageLightThemeBoxDecoration {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }

  /// Box decoration for the earnings details page.
  ///
  /// - **Returns**: A [BoxDecoration] with a semi-transparent background and rounded top corners.
  static BoxDecoration get earnDetailsPageBoxDecoration {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      color:
          Colors.transparent.withOpacity(0.5), // Semi-transparent background.
    );
  }

  /// Box decoration for the sign-up and sign-in pages.
  ///
  /// - **Returns**: A [BoxDecoration] with a yellow background, slightly rounded corners, and a border.
  static BoxDecoration get signPagesBoxDecoration {
    return BoxDecoration(
      color: ProjectCustomColors
          .mYellow, // Yellow background color from CustomColors.
      borderRadius: BorderRadius.circular(5), // Slightly rounded corners.
      border: Border.all(
        color: ProjectCustomColors.mYellow, // Border color matches background.
      ),
    );
  }

  /// Box decoration for the portfolio addition pages in dark theme.
  ///
  /// - **Returns**: A [BoxDecoration] with a light grey background and rounded corners.
  static BoxDecoration get addPortfolioPagesBoxDarkThemeDecoration {
    return BoxDecoration(
      color: ProjectCustomColors.mLightGrey,
      borderRadius: BorderRadius.circular(12),
    );
  }

  /// Box decoration for the portfolio addition pages in light theme.
  ///
  /// - **Returns**: A [BoxDecoration] with a slightly transparent grey background and rounded corners.
  static BoxDecoration get addPortfolioPagesLightThemeBoxDecoration {
    return BoxDecoration(
      color: ProjectCustomColors.mGreyPrimary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    );
  }

  /// Box decoration for coin details page widgets.
  ///
  /// - **Returns**: A [BoxDecoration] with a purple background and rounded corners.
  static BoxDecoration get coinDetailsPageWidgetsBoxDecoration {
    return BoxDecoration(
      color: ProjectCustomColors.mPurple,
      borderRadius: BorderRadius.circular(15),
    );
  }

  /// Box decoration for coin cards widgets.
  ///
  /// - **Returns**: A [BoxDecoration] with a purple background and rounded corners.
  static BoxDecoration get coinCardsWidgetsBoxDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(34), // Rounded corners
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0, 0.25, 0.75, 1],
        colors:
            ProjectCustomColors.earnCardGradientColors, // Gradient background
      ),
    );
  }

  /// Box decoration for earn cards widgets.
  ///
  /// - **Returns**: A [BoxDecoration] with and rounded corners.
  static BoxDecoration get earnCardsWidgetsBoxDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(34), // Rounded corners
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0, 0.25, 0.75, 1],
        colors:
            ProjectCustomColors.earnCardGradientColors, // Gradient background
      ),
    );
  }
}
