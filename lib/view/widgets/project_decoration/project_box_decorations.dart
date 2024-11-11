import 'package:flutter/material.dart';

import '../../../core/components/styles/custom_colors.dart';

final class ProjectBoxDecorations{
  const ProjectBoxDecorations._();

  static BoxDecoration get profilePageBoxDecoration{
    return const BoxDecoration(
      shape: BoxShape.rectangle,
      color: CustomColors.bgcolor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }
  static BoxDecoration get earnDetailsPageBoxDecoration {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)),
      color: Colors.transparent.withOpacity(0.5),
    );
  }
  static BoxDecoration get signPagesBoxDecoration {
    return BoxDecoration(
        color: CustomColors.mYellow,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: CustomColors.mYellow,
        ));
  }
}