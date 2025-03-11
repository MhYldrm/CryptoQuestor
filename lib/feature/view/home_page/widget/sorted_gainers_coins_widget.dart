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
part of '../home_page.dart';

class SortedGainersCoinsWidget extends StatelessWidget {
  const SortedGainersCoinsWidget({
    required this.isLoading,
    required this.sortedGainersCoins,
    super.key,
  });

  final bool? isLoading;
  final List sortedGainersCoins;

  @override
  Widget build(BuildContext context) {
    final geckoProvider = Provider.of<GeckoCoinsViewModel>(context);
    return SizedBox(
      height: ProjectSizes.size400.value,
      width: double.infinity,
      child: isLoading == true ?
          // Loading state
          const Center(
              child: CircularProgressIndicator(),)
          : geckoProvider.coins != null ?
              // Display the sorted list of gainers
              ListView.builder(
                  itemCount: sortedGainersCoins.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const ProjectPaddings.listViewSmallPadding(),
                      child: CoinListCard(
                        item: sortedGainersCoins[index],
                      ),
                    );
                  },
                )
              :
              // Error state when API too many request fails
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
