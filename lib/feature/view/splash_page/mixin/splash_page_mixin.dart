part of '../splash_page.dart';

mixin SplashPageMixin {
  int _currentIndex = 0;
  List<Widget> getImagesList(BuildContext context) {
    return [
      SplashImagesCardWidget(
        imageUrl: ProjectConstants.splashImageOnePath,
        description: context.mLocalizations.splashImageOne,
      ),
      SplashImagesCardWidget(
        imageUrl: ProjectConstants.splashImageTwoPath,
        description: context.mLocalizations.splashImageTwo,
      ),
      SplashImagesCardWidget(
        imageUrl: ProjectConstants.splashImageThreePath,
        description: context.mLocalizations.splashImageThree,
      ),
    ];
  }
}
