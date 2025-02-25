part of '../splash_page.dart';

class AnimatedIndicatorWidget extends StatelessWidget {
  const AnimatedIndicatorWidget({
    required this.activeIndex,
    required this.count,
    super.key,
  });

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      effect: WormEffect(
        dotHeight: ProjectSizes.size10.value,
        dotWidth: ProjectSizes.size10.value,
        spacing: ProjectSizes.size10.value,
        dotColor: ProjectCustomColors.mGreyPrimary,
        activeDotColor: context.isDarkMode
            ? ProjectCustomColors.mYellow
            : ProjectCustomColors.bgColor,
      ),
    );
  }
}
