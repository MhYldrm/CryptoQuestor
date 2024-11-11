import 'package:flutter/material.dart';
import '../../../../core/models/portfolio_coins_model.dart';
import '../../../widgets/port_coins_card.dart';

/// [portfolioCoinList] A list to display in the Listview widget
///
class PortfolioCoinsListViewWidget extends StatelessWidget {
  const PortfolioCoinsListViewWidget(
      {required this.portfolioCoinList, super.key});

  final List<PortfolioCoinsModel> portfolioCoinList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: portfolioCoinList.length,
      itemBuilder: (context, index) {
        final coins = portfolioCoinList[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: PortCoinsCard(
            imageUrl: coins.imageUrl,
            symbol: coins.symbol,
            name: coins.name,
            quantity: double.parse(coins.quantity),
            totalSpent: double.parse(coins.totalSpent),
          ),
        );
      },
    );
  }
}
