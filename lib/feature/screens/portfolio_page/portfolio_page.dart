import 'package:auto_route/annotations.dart';
import 'package:crypto_questor/feature/screens/portfolio_page/widgets/portfolio_coins_listview_widget.dart';
import 'package:crypto_questor/feature/screens/portfolio_page/widgets/total_spent_description_widget.dart';
import 'package:flutter/material.dart';
import '../../../product/components/styles/custom_colors.dart';
import '../../../product/components/styles/my_functions.dart';
import '../../widgets/empty_widget.dart';
import 'mixin/portfolio_page_mixin.dart';

@RoutePage()
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> with PortfolioPageMixin {
  @override
  void initState() {
    super.initState();
    fetchPortfolioCoinsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    // A function that sums the spent amounts of all coins in the portfolio and returns a double value named totalSpent.
    double totalSpentSum = 0;
    final res = MyFunctions().summarizeCoin(allCoinsInPortfolio);
    for (var item in res) {
      totalSpentSum += double.parse(item.totalSpent);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.bgcolor,
        appBar: buildCustomAppBar(context),
        body: Column(
          children: [
            const EmptyWidget(height: 30),
            Expanded(
                flex: 2,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : PortfolioCoinsListViewWidget(portfolioCoinList: res)),
            Expanded(
              flex: 1,
              child: TotalSpentDescriptionWidget(totalValue: totalSpentSum),
            ),
          ],
        ),
      ),
    );
  }
}