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
///
part of '../add_portfolio_page.dart';

final class AddPortfolioPageHeaderWidget extends StatelessWidget {
  const AddPortfolioPageHeaderWidget({
    required this.imageUrl,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    super.key,
    this.marketCapChangePercentage24H,
  });

  final String imageUrl;
  final String symbol;
  final String name;
  final double currentPrice;
  final double? marketCapChangePercentage24H;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: ProjectSizes.xLarge.value,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: context.isDarkMode
                          ? ProjectCustomColors.mWhitePrimary
                          : ProjectCustomColors.bgColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        imageUrl,
                        height: ProjectSizes.xsLarge.value,
                        width: ProjectSizes.xsLarge.value,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: ProjectSizes.small.value,
                    ),
                    Padding(
                      padding: const ProjectPaddings.topSmall(),
                      child: SizedBox(
                        height: ProjectSizes.xsLarge.value,
                        width: ProjectSizes.xxxxLarge.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              symbol.toString().toUpperCase(),
                              style: context.textThemeTitleMedium?.copyWith(
                                color: context.isDarkMode
                                    ? ProjectCustomColors.mWhitePrimary
                                    : ProjectCustomColors.bgColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                style: context.textThemeLabelLarge?.copyWith(
                                  color: ProjectCustomColors.mGreyPrimary,
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
                            '${currentPrice.toString()} \$',
                            style: context.textThemeTitleMedium?.copyWith(
                              color: context.isDarkMode
                                  ? ProjectCustomColors.mWhitePrimary
                                  : ProjectCustomColors.bgColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${marketCapChangePercentage24H?.toStringAsFixed(2)}%',
                            style: marketCapChangePercentage24H! >= 0
                                ? context.textThemeBodyLarge?.copyWith(
                                    color: Colors.green.shade500,
                                    fontWeight: FontWeight.w300)
                                : context.textThemeBodyMedium?.copyWith(
                                    color: Colors.red.shade400,
                                    fontWeight: FontWeight.w300,
                                  ),
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
              color: ProjectCustomColors.mLilacPrimary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
