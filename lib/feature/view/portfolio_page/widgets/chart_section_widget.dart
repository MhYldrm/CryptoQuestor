/// A widget that displays a chart section for the portfolio page.
///
/// This widget combines a pie chart showing the portfolio's distribution and a
/// description of the total spent versus the current value of the portfolio.
///
/// ### Responsibilities:
/// - Processes portfolio data by merging information from [PortfolioCoinsViewModel]
///   and [GeckoCoinsViewModel].
/// - Calculates the total spent and current value of the portfolio.
/// - Displays the data visually using a [PieChartWidget] and
///   a [TotalSpentDescriptionWidget].
///
/// ### UI Details:
/// - The pie chart provides an interactive visualization of the portfolio distribution.
/// - The total spent and current value are displayed below the pie chart.
///
part of '../portfolio_page.dart';

class ChartSectionWidget extends StatelessWidget {
  const ChartSectionWidget({
    required this.toolTipBehavior,
    super.key,
  });

  final TooltipBehavior toolTipBehavior;

  @override
  Widget build(BuildContext context) {
    return Consumer2<PortfolioCoinsViewModel, GeckoCoinsViewModel>(
      builder: (context, portfolioCoinsProvider, geckoProvider, child) {
        // Process portfolio coins by merging data from both providers.
        final resultList = ProjectFunctions().processPortfolioCoins(
          portfolioCoinsProvider.portfolioCoins,
          geckoProvider.coins ?? [],
        );

        // Initialize total spent and total current value variables.
        double totalSpent = 0;
        double totalCurrentValue = 0;

        // Calculate the total spent and current value of the portfolio.
        for (var coin in resultList) {
          totalSpent += double.parse(coin.totalSpent);
          totalCurrentValue += double.parse(coin.currentValue!);
        }

        return Column(
          children: [
            PieChartWidget(
              tooltipBehavior: toolTipBehavior,
              coinList: resultList, // List of coins to display.
            ),
            // Widget showing total spent versus total current value.
            TotalSpentDescriptionWidget(
              totalValue: totalSpent,
              totalCurrentValue: totalCurrentValue,
            ),
          ],
        );
      },
    );
  }
}
