part of '../splash_page.dart';

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
      effect: WormEffect(
        dotHeight: ApplicationSize.size10.value,
        dotWidth: ApplicationSize.size10.value,
        spacing: ApplicationSize.size10.value,
        dotColor: CustomColors.mGreyPrimary,
        activeDotColor:
            context.isDarkMode ? CustomColors.mYellow : CustomColors.bgcolor,
        paintStyle: PaintingStyle.fill,
      ),
    );
  }
}
