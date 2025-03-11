/// A widget that displays a list of portfolio coins in a ListView.
///
/// This widget takes a list of portfolio coins and displays them in a scrollable view.
/// It shows a loading indicator while the data is being fetched, and displays each coin's
/// details once loaded. If the portfolio is empty, a message will be shown.
///
/// ### Parameters:
/// - [portfolioCoinList] A list of [PortfolioCoinsModel] objects to display in the ListView.
/// - [isLoading] A boolean indicating whether the portfolio data is still being loaded.
///
/// ### Colors:
/// - [mWhitePrimary] The white color used for text when in dark mode.
/// - [bgColor] The background color used for text when in light mode.
///
/// ### UI Details:
/// - While data is loading, a [CircularProgressIndicator] is shown.
/// - If there are no coins, a message saying "You do not have any coins" is displayed.
/// - If there are portfolio coins, they are displayed in a scrollable list using [PortCoinsCard] widget.
///
part of '../portfolio_page.dart';

class PortfolioCoinsListViewWidget extends StatelessWidget {
  const PortfolioCoinsListViewWidget({
    required this.portfolioCoinList,
    required this.isLoading,
    super.key,
  });

  final List<PortfolioCoinsModel> portfolioCoinList;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final portfolioCoinsProvider = Provider.of<PortfolioCoinsViewModel>(context);

    return isLoading == true ? const Center(child: CircularProgressIndicator(),)
        : portfolioCoinsProvider.portfolioCoins.isNotEmpty
            ? ListView.builder(
                itemCount: portfolioCoinList.length,
                itemBuilder: (context, index) {
                  final coins = portfolioCoinList[index];
                  return Padding(
                    padding: const ProjectPaddings.listViewMediumPadding(),
                    child: PortCoinsCard(
                      imageUrl: coins.imageUrl,
                      symbol: coins.symbol,
                      name: coins.name,
                      quantity: double.parse(coins.quantity),
                      totalSpent: double.parse(coins.totalSpent),
                      currentValue: coins.currentValue.toString(),
                      priceChange24H: coins.priceChange24H!,
                    ),
                  );
                },
              )
            : Padding(
                padding: const ProjectPaddings.allXsSmall(),
                child: Center(
                  child: Text(
                    context.mLocalizations.isNotHaveAnyCoins,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? ProjectCustomColors.mWhitePrimary
                          : ProjectCustomColors.bgColor,
                    ),
                  ),
                ),
              );
  }
}
