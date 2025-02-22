import 'package:flutter/material.dart';

/// A custom class for defining padding values used across the project.
///
/// This class extends [EdgeInsets] and provides commonly used padding
/// values to maintain consistent spacing across the app. These padding
/// values can be reused in various widgets to ensure consistent UI layout.

final class ProjectPaddings extends EdgeInsets {
  /// Default constructor, provides no padding (all zeros).
  const ProjectPaddings() : super.all(0);

  /// Padding for all sides set to medium (16 units).
  /// This is used for general spacing where equal padding on all sides is required.
  const ProjectPaddings.allMedium() : super.all(16);

  /// Padding for the top only set to medium (20 units).
  /// This is useful for adding space at the top of a widget.
  const ProjectPaddings.topMedium() : super.only(top: 20);

  /// Padding for the left side only set to medium (30 units).
  /// This can be used when there is a need for extra space on the left side.
  const ProjectPaddings.leftMedium() : super.only(left: 30);

  /// Padding for horizontal sides (left and right) set to small (10 units).
  /// This is useful when a small horizontal padding is needed for elements.
  const ProjectPaddings.horizontalSmall() : super.symmetric(horizontal: 10);

  /// Padding for horizontal sides (left and right) set to medium (20 units).
  /// This is used when a medium horizontal space is required between elements.
  const ProjectPaddings.horizontalMedium() : super.symmetric(horizontal: 20);

  /// Padding for vertical sides (top and bottom) set to small (5 units).
  /// This is ideal for small vertical spacing between widgets.
  const ProjectPaddings.verticalSmall() : super.symmetric(vertical: 5);

  /// Padding for top and left sides set to small (10 units for top and 10 units for left).
  /// This can be used for widgets that need space from both top and left.
  const ProjectPaddings.topAndLeftSmall() : super.only(top: 10, left: 10);

  /// Padding for top and right sides with small top padding (5 units) and right padding (10 units).
  /// Useful when you need a specific padding for the top and right.
  const ProjectPaddings.topAndRightSmall() : super.only(right: 10, top: 5);

  /// Padding for bottom side only set to medium (20 units).
  /// This is commonly used when you need to add space at the bottom of a widget.
  const ProjectPaddings.bottomMedium() : super.only(bottom: 20);
}
