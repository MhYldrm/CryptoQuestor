import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../product/components/styles/custom_colors.dart';
import 'empty_widget.dart';

/// A card widget that displays information about a cryptocurrency in the portfolio
///
/// [symbol] Coin's symbol text
/// [price] Coin's current price
/// [name] Coin's name text
/// [url] Coin's image url
/// [balance] Quantity of coins in the user's portfolio
///
class CoinCard extends StatelessWidget {
  final String symbol, price, name;
  final String? url;
  final String? balance;

  const CoinCard({
    super.key,
    required this.symbol,
    this.url,
    required this.price,
    required this.name,
    this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container to style and hold the coin card
        Container(
          height: 165,
          width: 215,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34), // Rounded corners
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 0.25, 0.75, 1],
              colors: CustomColors.earnCardGradientColors, // Gradient background
            ),
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(34), // Rounded corners for the clip
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: context.isDarkMode
                      ? CustomColors.creditCardGradientDarkThemeColors
                      : CustomColors.creditCardGradientLightThemeColors,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EmptyWidget(height: 20),
                    Expanded(
                      flex: 1,
                      child: showTitlePart(context),
                    ),
                    Expanded(
                      flex: 1,
                      child: showSubtitlePart(context),
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

  // Displays the title part with the coin's symbol and name
  Row showTitlePart(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cryptocurrency logo image (URL)
        Image.network(
          url!,
          fit: BoxFit.fill,
          height: 45,
          width: 45,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                symbol.toUpperCase(), // Display the coin's symbol in uppercase
                style: context.textThemeTitleLarge?.copyWith(
                  color: context.isDarkMode
                      ? CustomColors.mWhitePrimary
                      : CustomColors.bgcolor,
                ),
              ),
              FittedBox(
                child: Text(
                  name, // Display the coin's name
                  style: context.textThemeLabelLarge?.copyWith(
                    color: context.isDarkMode
                        ? CustomColors.mWhitePrimary
                        : CustomColors.bgcolor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Displays the price and the current balance of the coin
  Column showSubtitlePart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total amount spent on the coin
        Text(
          "\$ $price",
          style: context.textThemeTitleMedium?.copyWith(
            color: context.isDarkMode
                ? CustomColors.mWhitePrimary
                : CustomColors.mPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Current balance of the coin in the portfolio
        Text(
          "$balance ${symbol.toUpperCase()}",
          style: context.textThemeLabelLarge?.copyWith(
            color: context.isDarkMode
                ? CustomColors.mGreyPrimary
                : CustomColors.bgcolor,
          ),
        ),
      ],
    );
  }
}
