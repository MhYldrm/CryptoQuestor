import 'package:flutter/material.dart';

final class ProjectPaddings extends EdgeInsets {
  const ProjectPaddings() : super.all(0);

  /// [ProjectPadding.allMedium] is 16
  const ProjectPaddings.allMedium() : super.all(16);
  const ProjectPaddings.topMedium() : super.only(top: 20);
  const ProjectPaddings.leftMedium() : super.only(left: 30);
  const ProjectPaddings.horizontalSmall() : super.symmetric(horizontal: 10);
  const ProjectPaddings.horizontalMedium() : super.symmetric(horizontal: 20);
  const ProjectPaddings.verticalSmall() : super.symmetric(vertical: 5);
  const ProjectPaddings.topAndLeftSmall() : super.only(top: 10,left: 10);
  const ProjectPaddings.topAndRightSmall() : super.only(right: 10, top: 5);
  const ProjectPaddings.bottomMedium() : super.only(bottom: 20);
}