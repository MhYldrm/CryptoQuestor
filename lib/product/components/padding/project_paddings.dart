import 'package:flutter/material.dart';

/// A utility class for defining padding values used across the project.
///
/// This class extends [EdgeInsets] and provides predefined padding values
/// to maintain consistent spacing throughout the app. These padding values
/// can be reused in various widgets to ensure a uniform UI layout.

final class ProjectPaddings extends EdgeInsets {
  /// Default constructor, provides no padding (all zeros).
  const ProjectPaddings() : super.all(0);

  // ─────────────────────── All Sides Padding ───────────────────────

  /// Padding applied to all sides (5.5 units).
  const ProjectPaddings.allxSmall() : super.all(5.5);

  /// Padding applied to all sides (12 units).
  const ProjectPaddings.allSmall() : super.all(12);

  /// Padding applied to all sides (16 units).
  const ProjectPaddings.allMedium() : super.all(16);

  /// Padding applied to all sides (25 units).
  const ProjectPaddings.allLarge() : super.all(25);

  // ─────────────────────── Single Side Padding ───────────────────────

  /// Padding applied to the top (10 units).
  const ProjectPaddings.topSmall() : super.only(top: 10);

  /// Padding applied to the top (20 units).
  const ProjectPaddings.topMedium() : super.only(top: 20);

  /// Padding applied to the left (30 units).
  const ProjectPaddings.leftMedium() : super.only(left: 30);

  /// Padding applied to the bottom (10 units).
  const ProjectPaddings.bottomSmall() : super.only(bottom: 10);

  /// Padding applied to the bottom (20 units).
  const ProjectPaddings.bottomMedium() : super.only(bottom: 20);

  // ─────────────────────── Symmetric Padding ───────────────────────

  /// Padding applied to the left and right (10 units).
  const ProjectPaddings.horizontalSmall() : super.symmetric(horizontal: 10);

  /// Padding applied to the left and right (15 units).
  const ProjectPaddings.horizontalXMedium() : super.symmetric(horizontal: 15);

  /// Padding applied to the left and right (20 units).
  const ProjectPaddings.horizontalMedium() : super.symmetric(horizontal: 20);

  /// Padding applied to the left and right (25 units).
  const ProjectPaddings.horizontalLarge() : super.symmetric(horizontal: 25);

  /// Padding applied to the left and right (20 units) and top and bottom (5 units).
  const ProjectPaddings.horizontalAndVerticalSmall()
      : super.symmetric(horizontal: 20, vertical: 5);

  /// Padding applied to the left and right (20 units) and top and bottom (20 units).
  const ProjectPaddings.horizontalAndVerticalMedium()
      : super.symmetric(horizontal: 20, vertical: 20);

  /// Padding applied to the top and bottom (5 units).
  const ProjectPaddings.verticalSmall() : super.symmetric(vertical: 5);

  /// Padding applied to the top and bottom (15 units).
  const ProjectPaddings.verticalMedium() : super.symmetric(vertical: 15);

  // ─────────────────────── Combination Padding ───────────────────────

  /// Padding applied to the top (10 units) and left (10 units).
  const ProjectPaddings.topAndLeftSmall() : super.only(top: 10, left: 10);

  /// Padding applied to the top (5 units) and right (10 units).
  const ProjectPaddings.topAndRightSmall() : super.only(right: 10, top: 5);

  /// Padding applied to the top (10 units), left (7 units), and right (7 units).
  const ProjectPaddings.topLeftAndRightSmall()
      : super.only(top: 10, right: 7, left: 7);

  // ─────────────────────── List View Padding ───────────────────────

  /// Padding applied only to the bottom (10 units).
  const ProjectPaddings.listViewSmallPadding() : super.fromLTRB(0, 0, 0, 10);

  /// Padding applied only to the bottom (15 units).
  const ProjectPaddings.listViewMediumPadding() : super.fromLTRB(0, 0, 0, 15);

  /// Padding applied to the left (10 units) and right (12 units).
  const ProjectPaddings.listViewLeftAndRightPaddingSmall()
      : super.fromLTRB(10, 0, 12, 0);
}
