import 'package:crypto_questor/feature/screens/splash_page/widgets/splash_images_card_widget.dart';
import 'package:crypto_questor/product/components/styles/application_constants.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';

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

