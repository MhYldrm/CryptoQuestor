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
part of '../home_page.dart';

class SortedHotCoinsWidget extends StatelessWidget {
  const SortedHotCoinsWidget({
    required this.isLoading,
    required this.sortedHotCoins,
    super.key,
  });

  final bool? isLoading;
  final List sortedHotCoins;

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
              // Display the sorted hot coins list
              ListView.builder(
                  itemCount: sortedHotCoins.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const ProjectPaddings.listViewSmallPadding(),
                      child: CoinListCard(
                        item: sortedHotCoins[index],
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
