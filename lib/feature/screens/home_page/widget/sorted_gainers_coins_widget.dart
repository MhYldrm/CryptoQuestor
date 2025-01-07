import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../providers/gecko_coins_provider.dart';
import '../../../widgets/coin_list_card.dart';

/// [SortedGainersCoinsWidget] is a stateless widget designed to display the list of top gaining coins.
///
/// ### Key Responsibilities:
/// - Displays a list of coins sorted by their market cap percentage change over the last 24 hours.
/// - Handles loading states and provides appropriate feedback if the API request fails.
///
/// ### Parameters:
/// - [isLoading] A boolean flag indicating whether the data is still being fetched.
/// - [sortedGainersCoins] A list of coins sorted by their market cap percentage change.
///
/// ### UI Details:
/// - Shows a loading indicator when [isLoading] is true.
/// - If the data is successfully fetched, displays the sorted coins as a vertical list of [CoinListCard] widgets.
/// - Displays an error message if the API too many request fails.
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
    final geckoProvider = Provider.of<GeckoCoinsProvider>(context);
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: isLoading == true
          ?
          // Loading state
          const Center(
              child: CircularProgressIndicator(),
            )
          : geckoProvider.coins != null
              ?
              // Display the sorted list of gainers
              ListView.builder(
                  itemCount: sortedGainersCoins.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: CoinListCard(
                        item: sortedGainersCoins[index],
                      ),
                    );
                  },
                )
              :
              // Error state when API too many request fails
              Padding(
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
