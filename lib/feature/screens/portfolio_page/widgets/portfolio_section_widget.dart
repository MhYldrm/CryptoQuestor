/// A widget that manages the portfolio section of the app.
///
/// This widget listens to changes from [PortfolioCoinsViewModel] and [GeckoCoinsViewModel].
/// It processes the portfolio coin data and displays it using the [PortfolioCoinsListViewWidget].
///
/// ### Responsibilities:
/// - Listens to updates in portfolio coins and gecko coins using [Provider].
/// - Processes the portfolio coins with up-to-date market data.
/// - Displays a list of portfolio coins in a scrollable format.
///
/// ### UI Details:
/// - Delegates the actual UI rendering to [PortfolioCoinsListViewWidget].
/// - Passes the processed portfolio coin list and loading status to the child widget.
///
part of '../portfolio_page.dart';
class PortfolioSectionWidget extends StatelessWidget {
  const PortfolioSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioCoinsViewModel>(
      builder: (context, portfolioCoinsProvider, child) {
        // Watch for updates from the GeckoCoinsViewModel
        final geckoProvider = context.watch<GeckoCoinsViewModel>();

        /// Processes the portfolio coins by merging local portfolio data
        /// with the latest market data fetched from GeckoCoinsViewModel.
        final resultList = MyFunctions().processPortfolioCoins(
          portfolioCoinsProvider.portfolioCoins,
          geckoProvider.coins ?? [],
        );

        /// Returns a widget that displays the portfolio coin list
        /// along with a loading indicator or empty state if applicable.
        return PortfolioCoinsListViewWidget(
          portfolioCoinList: resultList, // The processed list of portfolio coins
          isLoading: portfolioCoinsProvider.isLoading, // Whether the data is still loading
        );
      },
    );
  }
}