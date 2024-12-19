import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../product/components/styles/custom_colors.dart';

class SplashImagesCardWidget extends StatelessWidget {
  const SplashImagesCardWidget(
      {super.key, required this.imageUrl, required this.description});

  final String imageUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.projectTheme!.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 200,
            width: 300,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 80,
            width: 300,
            child: Text(
                description,
              style: GoogleFonts.permanentMarker(
                color: context.isDarkMode ? CustomColors.mYellow : CustomColors.bgcolor,
                fontSize: 20,
                fontWeight: FontWeight.w100,
              )
            ),
          ),
        ],
      ),
    );
  }
}
