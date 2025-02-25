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
part of '../home_page.dart';

class SortedLosersCoinsWidget extends StatelessWidget {
  const SortedLosersCoinsWidget({
    required this.isLoading,
    required this.sortedLosersCoins,
    super.key,
  });

  final bool? isLoading;
  final List sortedLosersCoins;

  @override
  Widget build(BuildContext context) {
    final geckoProvider = Provider.of<GeckoCoinsViewModel>(context);

    return SizedBox(
      height: ProjectSizes.size400.value,
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
                      padding: const ProjectPaddings.listViewSmallPadding(),
                      child: CoinListCard(
                        item: sortedLosersCoins[index],
                      ),
                    );
                  },
                )
              :
              // Error state when API request fails
              Padding(
                  padding: const ProjectPaddings.allxSmall(),
                  child: Center(
                    child: Text(
                      context.mLocalizations.isApiRequestFailed,
                      style: const TextStyle(
                        color: ProjectCustomColors.mWhitePrimary,
                      ),
                    ),
                  ),
                ),
    );
  }
}
