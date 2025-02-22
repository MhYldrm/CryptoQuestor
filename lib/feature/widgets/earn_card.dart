import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../product/components/styles/custom_colors.dart';

/// A card widget used to display earning opportunities on an exchange.
/// It includes the exchange logo, title, exchange name, and a button to view details.
/// [imageUrl] URL for the image (exchange logo).
/// [title] Title of the earning opportunity.
/// [exchangeName] Name of the exchange where the opportunity is available.
///
class EarnCard extends StatelessWidget {
  const EarnCard(
      {required this.imageUrl,
      required this.title,
      required this.exchangeName,
      super.key});
  final String imageUrl, title, exchangeName;

  @override
  Widget build(BuildContext context) {
    // Get the height and width of the screen for responsive design
    double height = MediaQuery.sizeOf(context).height;
    double widht = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Container(
          height: height / 6,
          width: widht / 1.05,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 0.25, 0.75, 1],
              colors: CustomColors.earnCardGradientColors,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: context.isDarkMode
                  ? CustomColors.creditCardGradientDarkThemeColors
                  : CustomColors.earnCardGradientLightThemeColors,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                        height: height / 8,
                        width: widht / 3,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: VerticalDivider(
                        thickness: 1,
                        color: CustomColors.mWhitePrimary,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: context.deviceWidht / 2,
                            child: AutoSizeText(
                              title,
                              style: context.textThemeTitleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.isDarkMode
                                ? CustomColors.mWhitePrimary
                                : CustomColors.bgcolor,
                              ),
                              maxLines: 1,
                              minFontSize: 11,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pin_drop,
                              size: 23,
                              color: context.isDarkMode
                                  ? CustomColors.mYellow
                                  : CustomColors.mRedPrimary,
                            ),
                            Text(
                              " - ${context.mLocalizations.exchange} $exchangeName",
                              style: context.textThemeTitleSmall?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: context.isDarkMode
                                    ? CustomColors.mWhitePrimary
                                    : CustomColors.mPurple,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 30),
                          child: Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: CustomColors.mYellow,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Center(
                              child: Text(
                                context.mLocalizations.goToDetails,
                                style: context.textThemeTitleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: CustomColors.mBlackPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
