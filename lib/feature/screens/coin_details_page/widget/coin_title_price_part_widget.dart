import 'package:flutter/material.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../intro_page/intro_page.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 65,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const IntroPage()));
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        imageUrl,
                        height: 55,
                        width: 55,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 55,
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              symbol.toString().toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: CustomColors.mWhitePrimary,
                                      fontWeight: FontWeight.bold),
                            ),
                            FittedBox(
                              child: Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: CustomColors.mGreyPrimary,
                                        fontWeight: FontWeight.w500),
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${currentPrice.toString()} \$",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: CustomColors.mWhitePrimary,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${marketCapChangePercentage24H?.toStringAsFixed(2)}%",
                            style: marketCapChangePercentage24H! >= 0
                                ? Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                color: Colors.green.shade300,
                                fontWeight: FontWeight.w300)
                                : Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                color: Colors.red.shade300,
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 0.5,
              color: CustomColors.mLilacPrimary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
