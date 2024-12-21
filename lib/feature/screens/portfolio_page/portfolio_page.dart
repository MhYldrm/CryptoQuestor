import 'package:crypto_questor/feature/screens/portfolio_page/widgets/pie_chart_widget.dart';
import 'package:crypto_questor/feature/screens/portfolio_page/widgets/portfolio_coins_listview_widget.dart';
import 'package:crypto_questor/feature/screens/portfolio_page/widgets/total_spent_description_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import '../../../product/components/styles/my_functions.dart';
import 'mixin/portfolio_page_mixin.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> with PortfolioPageMixin {
  @override
  Widget build(BuildContext context) {
    // A function that sums the spent amounts of all coins in the portfolio and returns a double value named totalSpent.
    double totalSpentSum = 0;
    final resultCoinList = MyFunctions().summarizeCoin(allCoinsInPortfolio);
    for (var item in resultCoinList) {
      totalSpentSum += double.parse(item.totalSpent);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.projectTheme!.primaryColor,
        appBar: buildCustomAppBar(context),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  PieChartWidget(
                      tooltipBehavior: toolTipBehavior,
                      coinList: resultCoinList,
                  ),
                  TotalSpentDescriptionWidget(totalValue: totalSpentSum),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : PortfolioCoinsListViewWidget(portfolioCoinList: resultCoinList)),
          ],
        ),
      ),
    );
  }
}