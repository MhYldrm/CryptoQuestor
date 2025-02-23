/// [low24H] The lowest price in the last 24 hours.
/// [high24H] The highest price in the last 24 hours.
/// [totalVolume] The total market cap of the coin.
/// [mPurple] 24H Details text background color
/// [mWhitePrimary] Total volume text White Color
/// [mGreyPrimary] (Low-High-Vol) text Grey Color
/// [red.shade300] Low price text Red Color
/// [green.shade300] High Price Text Green Color
///
part of '../coin_details_page.dart';

class CoinLowHighDescriptionWidget extends StatelessWidget {
  const CoinLowHighDescriptionWidget(
      {super.key,
      required this.low24H,
      required this.high24H,
      required this.totalVolume});

  final double low24H;
  final double high24H;
  final double totalVolume;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const ProjectPaddings.topLeftAndRightSmall(),
          child: SizedBox(
              height: ApplicationSize.size60.value,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const ProjectPaddings.bottomSmall(),
                    child: Container(
                      height: ApplicationSize.size45.value,
                      width: ApplicationSize.xxsLarge.value,
                      decoration: ProjectBoxDecorations
                          .coinDetailsPageWidgetsBoxDecoration,
                      child: Padding(
                        padding: const ProjectPaddings.allxSmall(),
                        child: Column(
                          children: [
                            Text(
                              context.mLocalizations.twentyHoursText,
                              style: context.textThemeBodySmall
                                  ?.copyWith(color: CustomColors.mWhitePrimary),
                            ),
                            Text(
                              context.mLocalizations.details,
                              style: context.textThemeLabelSmall?.copyWith(
                                  color: CustomColors.mWhitePrimary,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        context.mLocalizations.low,
                        style: context.textThemeTitleSmall?.copyWith(
                          color: context.isDarkMode
                              ? CustomColors.mWhitePrimary
                              : CustomColors.bgcolor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "\$${low24H.toString()}",
                        style: context.textThemeBodyMedium?.copyWith(
                            color: Colors.red.shade300,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        context.mLocalizations.high,
                        style: context.textThemeTitleSmall?.copyWith(
                          color: context.isDarkMode
                              ? CustomColors.mWhitePrimary
                              : CustomColors.bgcolor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "\$${high24H.toString()}",
                        style: context.textThemeBodyMedium?.copyWith(
                            color: Colors.green.shade300,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        ApplicationConstants.vol,
                        style: context.textThemeTitleSmall?.copyWith(
                          color: context.isDarkMode
                              ? CustomColors.mWhitePrimary
                              : CustomColors.bgcolor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "\$${totalVolume.toString()} M",
                        style: context.textThemeBodyMedium?.copyWith(
                          color: context.isDarkMode
                              ? CustomColors.mGreyPrimary
                              : CustomColors.bgcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
