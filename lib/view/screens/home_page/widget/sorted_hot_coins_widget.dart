import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/styles/custom_colors.dart';
import '../../../widgets/coin_list_card.dart';

/// A widget that displays a list of the most popular (hot) coins.
///
/// This widget shows the list of coins that are currently "hot" or trending, based on their total volume.
/// It handles the loading state and displays an error message if the API request fails.
///
/// [isLoading] - A flag that indicates whether the data is being loaded.
/// [sortedHotCoins] - A list of coins that are sorted by their trading volume (hot coins).
///
class SortedHotCoinsWidget extends StatelessWidget {
  const SortedHotCoinsWidget({
    super.key,
    required this.isLoading,
    required this.sortedHotCoins,
  });

  final bool? isLoading;
  final List sortedHotCoins;

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
                  itemCount: sortedHotCoins.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: CoinListCard(
                          item: sortedHotCoins[index],
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
