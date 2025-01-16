import 'package:crypto_questor/feature/screens/portfolio_page/widgets/chart_section_widget.dart';
import 'package:crypto_questor/feature/screens/portfolio_page/widgets/pie_chart_widget.dart';
import 'package:crypto_questor/feature/screens/portfolio_page/widgets/portfolio_coins_listview_widget.dart';
import 'package:crypto_questor/feature/screens/portfolio_page/widgets/portfolio_section_widget.dart';
import 'package:crypto_questor/feature/screens/portfolio_page/widgets/total_spent_description_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'mixin/portfolio_page_mixin.dart';

/// A page that displays the user's cryptocurrency portfolio.
///
/// The PortfolioPage widget shows an overview of the user's portfolio, including
/// a pie chart representing the distribution of assets, a total spent vs. total current value
/// summary, and a list of the portfolio's coins with their details.
///
/// ### Widgets:
/// - [PieChartWidget] Displays a pie chart showing the distribution of portfolio coins.
/// - [TotalSpentDescriptionWidget] Shows the total amount spent and the current total value of the portfolio.
/// - [PortfolioCoinsListViewWidget] Lists individual portfolio coins with their details.
///
/// ### State Management:
/// - Uses `Consumer2` to manage data from both the `PortfolioCoinsProvider` and `GeckoProvider`.
/// - The `PortfolioCoinsProvider` is used to retrieve the portfolio data from Firebase or local storage.
/// - The `GeckoProvider` fetches the current market values for each coin.
///

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> with PortfolioPageMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.projectTheme!.primaryColor,
        appBar: buildCustomAppBar(context),
        body: Column(
          children: [
            // First section: Pie chart and total spent description
            Expanded(
              flex: 3,
              child: ChartSectionWidget(toolTipBehavior: toolTipBehavior),
            ),

            // Second section: List of portfolio coins
            const Expanded(
              flex: 3,
              child: PortfolioSectionWidget(),
            ),
          ],
        ),
      ),
    );
  }
}