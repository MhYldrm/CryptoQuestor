import 'package:crypto_questor/feature/screens/splash_page/widgets/splash_images_card_widget.dart';
import 'package:flutter/material.dart';

mixin SplashPageMixin {
  int currentIndex = 0;

  final List<Widget> imagesList = [
    const SplashImagesCardWidget(
      imageUrl: "assets/splash1.png",
      description: "Keep your finger on the pulse of the crypto market!",
    ),
    const SplashImagesCardWidget(
      imageUrl: "assets/splash2.png",
      description: "Free crypto is just a click away!",
    ),
    const SplashImagesCardWidget(
      imageUrl: "assets/splash3.png",
      description:
          "Manage your portfolio and take control of your crypto journey!",
    ),
  ];
}
