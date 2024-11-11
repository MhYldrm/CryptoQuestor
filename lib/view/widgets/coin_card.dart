import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/view/widgets/empty_widget.dart';
import 'package:flutter/material.dart';


// Card widget showing coins in the portfolio on the homepage
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
        Container(
          height: 165,
          width: 215,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 0.25, 0.75, 1],
              colors: CustomColors.cardGradientColors
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 5, 8, 28),
                    Color.fromARGB(255, 17, 53, 87),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmptyWidget(height: 20),
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

  // Coin Logo- Symbol and Name Part
  Row showTitlePart(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                symbol.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: CustomColors.mWhitePrimary),
              ),
              FittedBox(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: CustomColors.mWhitePrimary,fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Total amount spent and current coin balance
  Column showSubtitlePart(BuildContext context) {
    return Column(
      children: [
        // Total Spent
        Text(
          "\$ $price",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mWhitePrimary),
        ),
        // Current coin Balance
        Text(
          "$balance ${symbol.toUpperCase()}",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: CustomColors.mGreyPrimary,fontWeight: FontWeight.w500),
        ),
      ],
    );
  }


}
