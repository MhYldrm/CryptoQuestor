import 'package:crypto_questor/product/components/styles/custom_colors.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../product/models/portfolio_coins_model.dart';

final class PieChartWidget extends StatelessWidget {
  const PieChartWidget(
      {super.key, required this.tooltipBehavior, required this.coinList});

  final TooltipBehavior tooltipBehavior;
  final List<PortfolioCoinsModel> coinList;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: const Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.left,
      ),
      tooltipBehavior: tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<PortfolioCoinsModel, String>(
          dataSource: coinList,
          xValueMapper: (PortfolioCoinsModel data, _) => data.quantity,
          yValueMapper: (PortfolioCoinsModel data, _) =>
              double.parse(data.totalSpent),
          dataLabelMapper: (PortfolioCoinsModel data, _) => data.symbol.toUpperCase(),
          sortFieldValueMapper: (PortfolioCoinsModel data, _) =>
              data.totalSpent,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
          onPointTap: (ChartPointDetails details) {
            final tappedCoin = coinList[details.pointIndex!];
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: context.projectTheme!.primaryColor,
                title: Row(
                  children: [
                    Text(tappedCoin.symbol.toUpperCase()),
                    const Spacer(),
                    Image.network(
                      tappedCoin.imageUrl,
                      height: 45,
                      width: 45,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                contentTextStyle: TextStyle(
                    color: context.isDarkMode
                        ? CustomColors.mWhitePrimary
                        : CustomColors.bgcolor),
                content: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity :"),
                        SizedBox(height: 10),
                        Text("Total Spent :"),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tappedCoin.quantity),
                        const SizedBox(height: 10),
                        Text(tappedCoin.totalSpent),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      context.mLocalizations.cancel,
                      style: TextStyle(
                        color: context.isDarkMode
                            ? CustomColors.mYellow
                            : CustomColors.mPinkPrimary,
                      ),
                    ),
                  ),
                ],
                scrollable: true,
              ),
            );
          },
        ),
      ],
    );
  }
}
