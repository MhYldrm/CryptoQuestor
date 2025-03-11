/// [AllCoinsWidget] is a stateless widget that displays a list of all coins fetched
/// from the CoinGecko API. It handles loading, error, and success states based on the provided data.
///
/// ### Key Responsibilities:
/// - Displays a loading indicator while data is being fetched.
/// - Shows a list of cryptocurrency data once the data is successfully retrieved.
/// - Displays an error message if the API too many request fails.
///
/// ### Parameters:
/// - [isLoading] A boolean indicating whether the data is still being fetched.
/// - [coinMarket] A list of [GeckoModel] containing the details of the fetched coins.
///
/// ### UI Details:
/// - If [isLoading] is true, a `CircularProgressIndicator` is displayed.
/// - If the data is successfully fetched, a vertical list of coins is displayed using the [CoinListCard] widget.
/// - If the API request fails, an error message is shown to the user.
///
part of '../home_page.dart';

class AllCoinsWidget extends StatelessWidget {
  const AllCoinsWidget({
    required this.isLoading,
    required this.coinMarket,
    super.key,
  });

  final bool? isLoading;
  final List<GeckoModel>? coinMarket;

  @override
  Widget build(BuildContext context) {
    final geckoProvider = Provider.of<GeckoCoinsViewModel>(context);
    return SizedBox(
      height: ProjectSizes.size400.value,
      width: double.infinity,
      child: isLoading == true
          ? const Center(child: CircularProgressIndicator(),) // Loading Indicator
          : geckoProvider.coins != null
              ? ListView.builder(
                  // List of coins
                  itemCount: coinMarket!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const ProjectPaddings.listViewSmallPadding(),
                      child: CoinListCard(
                        item: coinMarket![index],
                      ),
                    );
                  },
                )
              : Padding(
                  // Error message when API too many request fails
                  padding: const ProjectPaddings.allxSmall(),
                  child: Center(
                    child: Text(
                      context.mLocalizations.isApiRequestFailed,
                      style: TextStyle(
                        color: context.isDarkMode
                            ? ProjectCustomColors.mWhitePrimary
                            : ProjectCustomColors.bgColor,
                      ),
                    ),
                  ),
                ),
    );
  }
}
