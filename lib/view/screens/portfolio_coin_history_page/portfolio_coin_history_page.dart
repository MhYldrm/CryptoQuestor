import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/view/screens/portfolio_coin_history_page/mixin/portfolio_coin_history_mixin.dart';
import 'package:crypto_questor/view/screens/portfolio_coin_history_page/widget/all_transactions_widget.dart';
import 'package:flutter/material.dart';

class PortfolioCoinHistoryPage extends StatefulWidget {
  final List<dynamic> coinData;
  const PortfolioCoinHistoryPage({super.key, required this.coinData});

  @override
  State<PortfolioCoinHistoryPage> createState() =>
      _PortfolioCoinHistoryPageState();
}

class _PortfolioCoinHistoryPageState extends State<PortfolioCoinHistoryPage>
    with PortfolioCoinHistoryMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: CustomColors.bgcolor,
      appBar: showCustomAppBar(),
      body: AllTransactionsWidget(coinData: widget.coinData),
    ));
  }
}
