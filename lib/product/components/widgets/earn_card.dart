import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto_questor/product/components/project_decoration/project_box_decorations.dart';
import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';

import '../styles/project_custom_colors.dart';

/// A card widget used to display earning opportunities on an exchange.
/// It includes the exchange logo, title, exchange name, and a button to view details.
/// [imageUrl] URL for the image (exchange logo).
/// [title] Title of the earning opportunity.
/// [exchangeName] Name of the exchange where the opportunity is available.
///
class EarnCard extends StatelessWidget {
  const EarnCard({
    required this.imageUrl,
    required this.title,
    required this.exchangeName,
    super.key,
  });
  final String imageUrl;
  final String title;
  final String exchangeName;

  @override
  Widget build(BuildContext context) {
    // Get the height and width of the screen for responsive design
    return Column(
      children: [
        Container(
          height: context.deviceHeight / 6,
          width: context.deviceWidht / 1.05,
          padding: const EdgeInsets.all(1),
          decoration: ProjectBoxDecorations.earnCardsWidgetsBoxDecoration,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: context.isDarkMode
                      ? ProjectCustomColors.creditCardGradientDarkThemeColors
                      : ProjectCustomColors.earnCardGradientLightThemeColors,
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
                        height: context.deviceHeight / 8,
                        width: context.deviceWidht / 3,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: VerticalDivider(
                        thickness: 1,
                        color: ProjectCustomColors.mWhitePrimary,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
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
                                    ? ProjectCustomColors.mWhitePrimary
                                    : ProjectCustomColors.bgColor,
                              ),
                              maxLines: 1,
                              minFontSize: 11,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.pin_drop,
                              size: 23,
                              color: context.isDarkMode
                                  ? ProjectCustomColors.mYellow
                                  : ProjectCustomColors.mRedPrimary,
                            ),
                            Text(
                              ' - ${context.mLocalizations.exchange} $exchangeName',
                              style: context.textThemeTitleSmall?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: context.isDarkMode
                                    ? ProjectCustomColors.mWhitePrimary
                                    : ProjectCustomColors.mPurple,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 30,
                          ),
                          child: Container(
                            height: 40,
                            width: 140,
                            decoration: BoxDecoration(
                              color: ProjectCustomColors.mYellow,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Center(
                              child: Text(
                                context.mLocalizations.goToDetails,
                                style: context.textThemeTitleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: ProjectCustomColors.mBlackPrimary,
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
