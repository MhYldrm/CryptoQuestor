import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../widgets/coin_list_card.dart';

/// A widget that displays a list of the coins that have the largest loss in value.
///
/// This widget shows the list of coins that have experienced the largest decrease
/// in market cap over the past 24 hours, also known as "losers."
/// It handles the loading state and displays an error message if the API request fails.
///
/// [isLoading] - A flag that indicates whether the data is still being loaded.
/// [sortedLosersCoins] - A list of coins that are sorted by their market cap loss (losers).
///
class SortedLosersCoinsWidget extends StatelessWidget {
  const SortedLosersCoinsWidget({
    super.key,
    required this.isLoading,
    required this.sortedLosersCoins,
  });

  final bool? isLoading;
  final List sortedLosersCoins;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: isLoading == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isLoading == true
              ? ListView.builder(
                  itemCount: sortedLosersCoins.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: CoinListCard(
                          item: sortedLosersCoins[index],
                        ));
                  })
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      context.mLocalizations.isApiRequestFailed,
                      style: const TextStyle(color: CustomColors.mWhitePrimary),
                    ),
                  ),
                ),
    );
  }
}
