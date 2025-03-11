/// A widget that displays the portfolio coins section on the home page.
///
/// This widget combines a summary of the user's portfolio (via a credit card UI)
/// with a detailed list of portfolio coins. It processes data from
/// [PortfolioCoinsViewModel] and [GeckoCoinsViewModel] to calculate and display
/// the total spent and account balance.
///
/// ### Responsibilities:
/// - Retrieves and processes portfolio data from the providers.
/// - Calculates the total spent and current account balance based on portfolio data.
/// - Displays a credit card widget with portfolio summary and a list of coins.
///
/// ### UI Details:
/// - A [CreditCard] widget is used to display the user's total spent and account balance.
/// - A [PortfolioCoinsCardWidget] displays a list of coins with detailed information.
/// - Shows a loading indicator while data is being fetched.
///
part of '../home_page.dart';

class PortfolioCoinsSectionWidget extends StatelessWidget {
  const PortfolioCoinsSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioCoinsViewModel>(
      builder: (context, portfolioCoinsProvider, child) {
        final geckoProvider = context.watch<GeckoCoinsViewModel>();

        // Variables to calculate the total spent and account balance.
        double totalSpent = 0;
        double accountBalance = 0;

        // Display a loading indicator if gecko data is still loading.
        if (geckoProvider.isLoading) {
          return const CircularProgressIndicator();
        }

        /// [resultList] A list that merges buy/sell transactions of coins from Firebase
        /// and combines them into a single data entry per coin.
        final resultList = ProjectFunctions().processPortfolioCoins(
          portfolioCoinsProvider.portfolioCoins,
          geckoProvider.coins ?? [],
        );

        // Calculate total spent and current account balance from the result list.
        for (var coin in resultList) {
          totalSpent += double.parse(coin.totalSpent); // Total money spent on coins.
          accountBalance += double.parse(coin.currentValue!); // Current total value of coins.
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Credit card widget displaying portfolio summary.
            CreditCard(
              // Current portfolio balance.
              totalCurrentValue: accountBalance,

              // Total amount spent on portfolio.
              totalSpent: totalSpent,
            ),
            EmptyWidget(
                height: ProjectSizes.size30.value),

            // A widget displaying a list of the user's portfolio coins.
            PortfolioCoinsCardWidget(
              // Original portfolio data.
              portfolioCoins: portfolioCoinsProvider.portfolioCoins,

              // Processed coin data.
              resultList: resultList,

              // Whether the data is loading.
              isLoading: portfolioCoinsProvider.isLoading,
            ),
          ],
        );
      },
    );
  }
}
