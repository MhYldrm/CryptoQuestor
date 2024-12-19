import 'package:crypto_questor/feature/screens/portfolio_coin_history_page/widget/all_transactions_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'mixin/portfolio_coin_history_mixin.dart';

final class PortfolioCoinHistoryPage extends StatefulWidget {
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
      backgroundColor: context.projectTheme!.primaryColor,
      appBar: showCustomAppBar(),
      body: AllTransactionsWidget(coinData: widget.coinData),
    ));
  }
}
