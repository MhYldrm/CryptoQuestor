import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../product/components/styles/custom_colors.dart';
import '../../../providers/gecko_coins_provider.dart';
import '../../../widgets/coin_list_card.dart';

/// [SortedHotCoinsWidget] is a stateless widget that displays a list of the most popular (hot) coins.
///
/// ### Key Responsibilities:
/// - Displays a list of trending coins sorted by their total trading volume.
/// - Handles loading and error states appropriately.
///
/// ### Parameters:
/// - [isLoading] A boolean flag indicating whether the data is still being fetched.
/// - [sortedHotCoins] A list of coins sorted by their trading volume (hot coins).
///
/// ### UI Details:
/// - Shows a [CircularProgressIndicator] while data is being fetched.
/// - Displays a vertical list of [CoinListCard] widgets when data is available.
/// - Displays an error message if the API too many request fails.
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
      // Display the sorted hot coins list
      ListView.builder(
        itemCount: sortedHotCoins.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: CoinListCard(
              item: sortedHotCoins[index],
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
