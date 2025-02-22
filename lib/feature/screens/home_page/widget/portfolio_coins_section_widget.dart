import 'package:crypto_questor/feature/screens/home_page/widget/portfolio_coins_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../product/components/styles/my_functions.dart';
import '../../../view_models/gecko_coins_view_model.dart';
import '../../../view_models/portfolio_coins_view_model.dart';
import '../../../widgets/credit_card.dart';
import '../../../widgets/empty_widget.dart';

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
        final resultList = MyFunctions().processPortfolioCoins(
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
              totalCurrentValue: accountBalance, // Current portfolio balance.
              totalSpent: totalSpent, // Total amount spent on portfolio.
            ),
            const EmptyWidget(height: 30), // Spacing between widgets.

            // A widget displaying a list of the user's portfolio coins.
            PortfolioCoinsCardWidget(
              portfolioCoins: portfolioCoinsProvider.portfolioCoins, // Original portfolio data.
              resultList: resultList, // Processed coin data.
              isLoading: portfolioCoinsProvider.isLoading, // Whether the data is loading.
            ),
          ],
        );
      },
    );
  }
}
