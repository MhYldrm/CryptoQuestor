/// [imageUrl] Get coin image URL.
/// [symbol] Indicates Coin Symbol.
/// [name] Indicates Coin Name.
/// [currentPrice] Indicates Coin Current Price.
/// [marketCapChangePercentage24H] Indicates Coin Percentage 24H.
/// [mWhitePrimary] Coins Symbol and Current Price Text White Color
/// [mGreyPrimary] Coins Name Text Grey Color
/// [red.shade300] if Coin Percentage 24H. is negative => percentage text Red Color
/// [green.shade300] if Coin Percentage 24H. is positive => percentage text Green Color
///
part of '../coin_details_page.dart';

final class CoinTitlePricePartWidget extends StatelessWidget {
  const CoinTitlePricePartWidget(
      {super.key,
      required this.imageUrl,
      required this.symbol,
      required this.name,
      required this.currentPrice,
      this.marketCapChangePercentage24H});

  final String imageUrl;
  final String symbol;
  final String name;
  final double currentPrice;
  final double? marketCapChangePercentage24H;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.horizontalXMedium(),
      child: Column(
        children: [
          SizedBox(
            height: ApplicationSize.xLarge.value,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const ProjectPaddings.topSmall(),
                  child: IconButton(
                      onPressed: () {
                        context.push(const IntroPage());
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        imageUrl,
                        height: ApplicationSize.xsLarge.value,
                        width: ApplicationSize.xsLarge.value,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: ApplicationSize.small.value,
                    ),
                    Padding(
                      padding: const ProjectPaddings.topSmall(),
                      child: SizedBox(
                        height: ApplicationSize.xsLarge.value,
                        width: ApplicationSize.xxxxLarge.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              symbol.toString().toUpperCase(),
                              style: context.textThemeTitleMedium?.copyWith(
                                color: context.isDarkMode
                                    ? CustomColors.mWhitePrimary
                                    : CustomColors.bgcolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                style: context.textThemeLabelLarge?.copyWith(
                                  color: CustomColors.mGreyPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Padding(
                      padding: const ProjectPaddings.topSmall(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${currentPrice.toString()} \$",
                            style: context.textThemeTitleMedium?.copyWith(
                              color: context.isDarkMode
                                  ? CustomColors.mWhitePrimary
                                  : CustomColors.bgcolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${marketCapChangePercentage24H?.toStringAsFixed(2)}%",
                            style: marketCapChangePercentage24H! >= 0
                                ? context.textThemeBodyLarge?.copyWith(
                                    color: Colors.green.shade500,
                                    fontWeight: FontWeight.w300)
                                : context.textThemeBodyMedium?.copyWith(
                                    color: Colors.red.shade400,
                                    fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const ProjectPaddings.horizontalSmall(),
            child: Divider(
              thickness: 0.5,
              color: context.isDarkMode
                  ? CustomColors.mLilacPrimary.withOpacity(0.7)
                  : CustomColors.bgcolor,
            ),
          ),
        ],
      ),
    );
  }
}
