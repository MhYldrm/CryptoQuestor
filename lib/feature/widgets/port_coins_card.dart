import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../product/components/styles/custom_colors.dart';

/// A custom card widget to display information about a cryptocurrency coin in the portfolio.
/// Displays the coin's symbol, quantity, and total spent value.
/// [name] The name of the coin (e.g., "Bitcoin")
/// [symbol] The symbol of the coin (e.g., "BTC")
/// [imageUrl] URL of the coin's image (e.g., the logo)
/// [quantity] The quantity of coins the user has
/// [totalSpent] The total amount spent on this cryptocurrency
///
class PortCoinsCard extends StatefulWidget {
  const PortCoinsCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.quantity,
    required this.totalSpent,
  });

  final String name; // Name of the coin
  final String symbol; // Symbol of the coin (e.g., "BTC")
  final String imageUrl; // Image URL for the coin (usually its logo)
  final double quantity; // The quantity of coins in the user's portfolio
  final double totalSpent; // The total amount the user has spent on the coins

  @override
  State<PortCoinsCard> createState() => _PortCoinsCardState();
}

class _PortCoinsCardState extends State<PortCoinsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75, // Fixed height for the card
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        color: CustomColors.coinsCardColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  height: 35,
                  width: 35,
                ),
                const SizedBox(
                  width: 15,
                ),
                // Coin symbol (e.g., "BTC", "ETH")
                Text(
                  widget.symbol.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Right section containing coin quantity and total spent
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Quantity of the cryptocurrency in the user's portfolio
                  Text(
                    widget.quantity.toString(),
                    style: context.textThemeBodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    "\$ ${widget.totalSpent.toStringAsFixed(2)}",
                    style: context.textThemeBodyMedium?.copyWith(
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
