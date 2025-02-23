part of '../splash_page.dart';

mixin SplashPageMixin {
  int currentIndex = 0;
  List<Widget> getImagesList(BuildContext context) {
    return [
      SplashImagesCardWidget(
        imageUrl: ApplicationConstants.splashImageOnePath,
        description: context.mLocalizations.splashImageOne,
      ),
      SplashImagesCardWidget(
        imageUrl: ApplicationConstants.splashImageTwoPath,
        description: context.mLocalizations.splashImageTwo,
      ),
      SplashImagesCardWidget(
        imageUrl: ApplicationConstants.splashImageThreePath,
        description: context.mLocalizations.splashImageThree,
      ),
    ];
  }
}
