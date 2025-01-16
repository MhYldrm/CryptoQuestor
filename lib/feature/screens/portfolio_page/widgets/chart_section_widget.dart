import 'package:crypto_questor/feature/screens/portfolio_page/widgets/pie_chart_widget.dart';
import 'package:crypto_questor/feature/screens/portfolio_page/widgets/total_spent_description_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../product/components/styles/my_functions.dart';
import '../../../view_models/gecko_coins_view_model.dart';
import '../../../view_models/portfolio_coins_view_model.dart';

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

class ChartSectionWidget extends StatelessWidget {
  const ChartSectionWidget({
    super.key,
    required this.toolTipBehavior,
  });

  final TooltipBehavior toolTipBehavior;

  @override
  Widget build(BuildContext context) {
    return Consumer2<PortfolioCoinsViewModel, GeckoCoinsViewModel>(
      builder: (context, portfolioCoinsProvider, geckoProvider, child) {
        // Process portfolio coins by merging data from both providers.
        final resultList = MyFunctions().processPortfolioCoins(
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
