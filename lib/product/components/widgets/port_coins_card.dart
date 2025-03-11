import 'package:crypto_questor/product/components/padding/project_paddings.dart';
import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:crypto_questor/product/components/styles/project_functions.dart';
import 'package:crypto_questor/product/extension/project_extensions.dart';
import 'package:flutter/material.dart';
import '../styles/project_custom_colors.dart';

/// [PortCoinsCard] is a stateful widget that displays detailed information about a cryptocurrency
/// in the user's portfolio. It shows the coin's symbol, quantity, total spent value, and calculates
/// the percentage change in value based on the current price and the amount spent.
///
/// ### Key Responsibilities:
/// - Displays the coin's symbol and logo (from the provided URL).
/// - Shows the quantity of the cryptocurrency the user owns.
/// - Displays the total amount the user has spent on the coin.
/// - Shows the current value of the coin and calculates the percentage change (Profit/Loss) based on
///   the current value and the total spent.
///
/// ### Parameters:
/// [name] The name of the coin (e.g., "Bitcoin")
/// [symbol] The symbol of the coin (e.g., "BTC")
/// [imageUrl] URL of the coin's image (e.g., the logo)
/// [quantity] The quantity of coins the user has
/// [totalSpent] The total amount spent on this cryptocurrency
/// [currentValue] The current value of one coin
/// [priceChange24H] The price change in the last 24 hours
///

class PortCoinsCard extends StatefulWidget {
  const PortCoinsCard({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.quantity,
    required this.totalSpent,
    required this.currentValue,
    required this.priceChange24H,
    super.key,
  });

  final String name;
  final String symbol;
  final String imageUrl;
  final double quantity;
  final double totalSpent;
  final String currentValue;
  final double priceChange24H;

  @override
  State<PortCoinsCard> createState() => _PortCoinsCardState();
}

class _PortCoinsCardState extends State<PortCoinsCard> {
  @override
  Widget build(BuildContext context) {
    // Calculate the percentage difference between current value and total spent
    double percentage = ProjectFunctions().calculatePercentage(
      double.parse(widget.currentValue),
      widget.totalSpent,
    );

    // Build the card layout with coin details
    return Container(
      height: ProjectSizes.size125.value, // Fixed height for the card
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.projectTheme!.colorScheme
            .secondary,
      ),
      child: Padding(
        padding: const ProjectPaddings.horizontalLarge(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left section containing coin image and symbol
            Row(
              children: [
                // Image of the coin (from the provided URL)
                Image.network(
                  widget.imageUrl,
                  fit: BoxFit.fill,
                  height: ProjectSizes.size35.value,
                  width: ProjectSizes.size35.value,
                ),
                SizedBox(
                  height: ProjectSizes.xSmall.value,
                ),
                // Coin symbol (e.g., "BTC", "ETH")
                Text(
                  widget.symbol.toUpperCase(),
                  style: context.textThemeTitleMedium?.copyWith(
                    color: context.isDarkMode
                        ? ProjectCustomColors.mWhitePrimary
                        : ProjectCustomColors.bgColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const ProjectPaddings.verticalMedium(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quantity of the cryptocurrency in the user's portfolio
                  Text(
                    context.mLocalizations.quantityText,
                    style: context.textThemeBodyMedium?.copyWith(
                      color: context.isDarkMode
                          ? ProjectCustomColors.mWhitePrimary
                          : ProjectCustomColors.bgColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: ProjectSizes.size5.value,
                  ),
                  Text(
                    context.mLocalizations.currentValue,
                    style: context.textThemeBodyMedium?.copyWith(
                      color: context.isDarkMode
                          ? ProjectCustomColors.mWhitePrimary
                          : ProjectCustomColors.bgColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: ProjectSizes.size5.value,
                  ),
                  Text(
                    context.mLocalizations.totalSpent,
                    style: context.textThemeBodyMedium?.copyWith(
                      color: context.isDarkMode
                          ? ProjectCustomColors.mWhitePrimary
                          : ProjectCustomColors.bgColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: ProjectSizes.size5.value,
                  ),
                  Text(
                    context.mLocalizations.pnl,
                    style: context.textThemeBodySmall?.copyWith(
                      color: context.isDarkMode
                          ? ProjectCustomColors.mWhitePrimary
                          : ProjectCustomColors.bgColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            // Right section containing coin quantity, current value, and total spent
            Padding(
              padding: const ProjectPaddings.verticalMedium(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Quantity of the cryptocurrency in the user's portfolio
                  Text(
                    '${widget.quantity.toString()} ${widget.symbol.toUpperCase()}',
                    style: context.textThemeBodyMedium?.copyWith(
                      color: context.isDarkMode
                          ? ProjectCustomColors.mWhitePrimary
                          : ProjectCustomColors.bgColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: ProjectSizes.size5.value,
                  ),
                  // Current value of the cryptocurrency
                  Text(
                    '\$ ${widget.currentValue}',
                    style: context.textThemeBodyMedium?.copyWith(
                      color: double.tryParse(widget.currentValue)! >=
                              widget.totalSpent
                          ? ProjectCustomColors
                              .mGreenPrimary // Green if current value is higher
                          : ProjectCustomColors
                              .mRedPrimary, // Red if current value is lower
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: ProjectSizes.size5.value,
                  ),
                  // Total spent on the cryptocurrency
                  Text(
                    '\$ ${widget.totalSpent.toStringAsFixed(2)}',
                    style: context.textThemeBodyMedium?.copyWith(
                      color: context.isDarkMode
                          ? ProjectCustomColors.mWhitePrimary
                          : ProjectCustomColors.bgColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: ProjectSizes.size5.value,
                  ),
                  // Percentage difference between current value and total spent
                  Text(
                    '% ${percentage.toStringAsFixed(2)}',
                    style: context.textThemeBodySmall?.copyWith(
                      color: percentage >= 0
                          ? ProjectCustomColors
                              .mGreenPrimary // Green if the value is positive
                          : ProjectCustomColors
                              .mRedPrimary, // Red if the value is negative
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
