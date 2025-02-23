/// [PortfolioCoinsCardWidget] is a stateless widget designed to display the user's portfolio of coins.
///
/// ### Key Responsibilities:
/// - Displays a horizontal list of coins currently in the user's portfolio.
/// - Provides quick access to the detailed history of a selected portfolio coin.
/// - Handles scenarios where the portfolio is empty or still loading.
///
/// ### Parameters:
/// - [portfolioCoins] A list containing raw data of portfolio coins.
/// - [resultList] A processed list of [PortfolioCoinsModel], which includes details such as:
///   - Coin name, symbol, and image URL.
///   - Current value, balance, and total spent for each coin.
/// - [isLoading] A boolean flag to indicate whether the portfolio data is being fetched.
///
/// ### UI Details:
/// - Shows a "My Portfolio" title section at the top.
/// - Displays a [CircularProgressIndicator] if the data is still loading.
/// - If there are coins in the portfolio, it shows them as [CoinCard] widgets in a horizontal list.
/// - If the portfolio is empty, a message like "You have not any coin in portfolio" is displayed.
///
part of '../home_page.dart';

final class PortfolioCoinsCardWidget extends StatelessWidget {
  const PortfolioCoinsCardWidget({
    super.key,
    required this.portfolioCoins,
    required this.resultList,
    required this.isLoading,
  });

  final List<dynamic> portfolioCoins;
  final List<PortfolioCoinsModel> resultList;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Portfolio title section
        Padding(
          padding: const ProjectPaddings.horizontalAndVerticalSmall(),
          child: Text(
            context.mLocalizations.myPortfolio,
            style: context.textThemeBodyLarge?.copyWith(
              color: context.projectTheme!.secondaryHeaderColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Portfolio coins list or loading/empty message
        SizedBox(
          height: ApplicationSize.size170.value,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator()) // Loading state
              : resultList.isNotEmpty
                  ?
                  // Display the portfolio coins as a horizontal list
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: resultList.length,
                      itemBuilder: (context, index) {
                        final portfolio = resultList[index];
                        return Padding(
                          padding: const ProjectPaddings
                              .listViewLeftAndRightPaddingSmall(),
                          child: InkWell(
                            onTap: () {
                              context.push(
                                PortfolioCoinHistoryPage(
                                    coinData: portfolioCoins),
                              );
                            },
                            child: CoinCard(
                              symbol: portfolio.symbol,
                              price: portfolio.currentValue!,
                              name: portfolio.name,
                              url: portfolio.imageUrl,
                              balance: portfolio.quantity,
                            ),
                          ),
                        );
                      },
                    )
                  :
                  // Display a message when the portfolio is empty
                  Center(
                      child: FittedBox(
                        child: Text(
                          context.mLocalizations.isNotHaveAnyCoins,
                          style: context.textThemeTitleMedium!.copyWith(
                            color: context.projectTheme!.secondaryHeaderColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
        ),
      ],
    );
  }
}
