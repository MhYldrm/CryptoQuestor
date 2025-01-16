import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../view_models/gecko_coins_view_model.dart';
import '../../../widgets/coin_list_card.dart';

/// [SortedLosersCoinsWidget] is a stateless widget that displays a list of coins
/// with the largest losses in value (losers) over the past 24 hours.
///
/// ### Key Responsibilities:
/// - Displays a list of "losers" coins sorted by their largest market cap loss.
/// - Handles loading and error states appropriately.
///
/// ### Parameters:
/// - [isLoading] A boolean flag indicating whether the data is being fetched.
/// - [sortedLosersCoins] A list of coins sorted by their market cap loss.
///
/// ### UI Details:
/// - Shows a [CircularProgressIndicator] while data is being loaded.
/// - Displays a vertical list of [CoinListCard] widgets when data is available.
/// - Displays an error message if the API too many request fails.
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
    final geckoProvider = Provider.of<GeckoCoinsViewModel>(context);

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
              // Display the sorted losers coins list
              ListView.builder(
                  itemCount: sortedLosersCoins.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: CoinListCard(
                        item: sortedLosersCoins[index],
                      ),
                    );
                  },
                )
              :
              // Error state when API request fails
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
