import 'package:crypto_questor/product/components/project_decoration/project_box_decorations.dart';
import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';
import '../styles/project_custom_colors.dart';
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
  const CoinCard({
    required this.symbol,
    required this.price,
    required this.name,
    super.key,
    this.url,
    this.balance,
  });
  final String symbol;
  final String price;
  final String name;
  final String? url;
  final String? balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container to style and hold the coin card
        Container(
          height: ProjectSizes.size165.value,
          width: ProjectSizes.size215.value,
          padding: const EdgeInsets.all(1),
          decoration: ProjectBoxDecorations.coinCardsWidgetsBoxDecoration,
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(34), // Rounded corners for the clip
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: context.isDarkMode
                      ? ProjectCustomColors.creditCardGradientDarkThemeColors
                      : ProjectCustomColors.creditCardGradientLightThemeColors,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmptyWidget(height: ProjectSizes.size20.value),
                    Expanded(
                      child: showTitlePart(context),
                    ),
                    Expanded(
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
          height: ProjectSizes.size45.value,
          width: ProjectSizes.size45.value,
        ),
        SizedBox(width: ProjectSizes.size20.value),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                symbol.toUpperCase(), // Display the coin's symbol in uppercase
                style: context.textThemeTitleLarge?.copyWith(
                  color: context.isDarkMode
                      ? ProjectCustomColors.mWhitePrimary
                      : ProjectCustomColors.bgColor,
                ),
              ),
              FittedBox(
                child: Text(
                  name, // Display the coin's name
                  style: context.textThemeLabelLarge?.copyWith(
                    color: context.isDarkMode
                        ? ProjectCustomColors.mWhitePrimary
                        : ProjectCustomColors.bgColor,
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
          '\$ $price',
          style: context.textThemeTitleMedium?.copyWith(
            color: context.isDarkMode
                ? ProjectCustomColors.mWhitePrimary
                : ProjectCustomColors.mPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Current balance of the coin in the portfolio
        Text(
          '$balance ${symbol.toUpperCase()}',
          style: context.textThemeLabelLarge?.copyWith(
            color: context.isDarkMode
                ? ProjectCustomColors.mGreyPrimary
                : ProjectCustomColors.bgColor,
          ),
        ),
      ],
    );
  }
}
