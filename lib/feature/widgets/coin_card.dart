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
  final String? url; // URL for the cryptocurrency's logo
  final String? balance; // Current balance of the cryptocurrency

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
              colors: CustomColors.cardGradientColors, // Gradient background
            ),
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(34), // Rounded corners for the clip
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 5, 8, 28), // Darker blue gradient
                    Color.fromARGB(255, 17, 53, 87), // Lighter blue gradient
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15), // Padding on the left
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Align children to the start (left)
                  children: [
                    const EmptyWidget(
                        height: 20), // Placeholder widget with empty space
                    Expanded(
                      flex: 1,
                      child: showTitlePart(
                          context), // Coin symbol and name section
                    ),
                    Expanded(
                      flex: 1,
                      child: showSubtitlePart(
                          context), // Price and balance section
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
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align items to the start (top)
      children: [
        // Cryptocurrency logo image (URL)
        Image.network(
          url!,
          fit: BoxFit.fill,
          height: 45,
          width: 45,
        ),
        const SizedBox(width: 20), // Space between logo and text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                symbol.toUpperCase(), // Display the coin's symbol in uppercase
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: CustomColors.mWhitePrimary),
              ),
              FittedBox(
                child: Text(
                  name, // Display the coin's name
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: CustomColors.mWhitePrimary,
                      fontWeight: FontWeight.w300),
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
      children: [
        // Total amount spent on the coin
        Text(
          "\$ $price",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: CustomColors.mWhitePrimary),
        ),
        // Current balance of the coin in the portfolio
        Text(
          "$balance ${symbol.toUpperCase()}",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: CustomColors.mGreyPrimary, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}