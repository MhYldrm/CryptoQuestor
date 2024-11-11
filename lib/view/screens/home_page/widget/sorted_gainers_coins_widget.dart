import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../widgets/coin_list_card.dart';

/// A widget that displays a list of sorted gainers' coins.
///
/// This widget shows the list of coins that have gained the most, based on their market cap change in the last 24 hours.
/// It also handles the loading state and displays an error message if the API request fails.
///
/// [isLoading] - A flag that indicates whether the data is being loaded.
/// [sortedGainersCoins] - A list of coins sorted by their market cap change percentage in the last 24 hours.
///
class SortedGainersCoinsWidget extends StatelessWidget {
  const SortedGainersCoinsWidget({
    super.key,
    required this.isLoading,
    required this.sortedGainersCoins,
  });

  final bool? isLoading;
  final List sortedGainersCoins;

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
                  itemCount: sortedGainersCoins.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: CoinListCard(
                          item: sortedGainersCoins[index],
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
