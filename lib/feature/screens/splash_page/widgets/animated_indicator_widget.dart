import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../product/components/styles/custom_colors.dart';

class AnimatedIndicatorWidget extends StatelessWidget {
  const AnimatedIndicatorWidget({
    super.key,
    required this.activeIndex,
    required this.count,
  });

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      axisDirection: Axis.horizontal,
      effect: const WormEffect(
        dotHeight: 10,
        dotWidth: 10,
        spacing: 10,
        dotColor: CustomColors.mGreyPrimary,
        activeDotColor: CustomColors.mYellow,
        paintStyle: PaintingStyle.fill,
      ),
    );
  }
}
