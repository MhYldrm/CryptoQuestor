/// A widget that displays a pie chart of the portfolio's coin distribution.
///
/// This widget renders a pie chart using [SfCircularChart] that visualizes the distribution of
/// portfolio coins based on their total spent value. Each coin in the portfolio is represented as
/// a slice of the pie, and clicking on any slice shows a detailed view of the coin's information.
///
/// ### Parameters:
/// - [tooltipBehavior] Tooltip behavior for displaying additional info when hovering over a slice.
/// - [coinList] A list of [PortfolioCoinsModel] objects representing the coins in the user's portfolio.
///
/// ### Colors:
/// - [mWhitePrimary] White color used for text in dark mode.
/// - [bgColor] Background color used for text in light mode.
/// - [mYellow] Yellow color used for the pie chart labels in dark mode.
/// - [mPinkPrimary] Pink color used for the cancel button text.
///
/// ### UI Details:
/// - The pie chart displays the total spent value of each coin in the portfolio.
/// - On tapping a slice, a dialog appears showing detailed information about the coin (quantity, total spent).
/// - The tooltip shows when hovering over each slice to give additional data on the coin.
///

part of '../portfolio_page.dart';

final class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    required this.tooltipBehavior,
    required this.coinList,
    super.key,
  });

  // Tooltip behavior for the chart to display data when hovering over the chart
  final TooltipBehavior tooltipBehavior;

  // The list of portfolio coins to be shown in the pie chart
  final List<PortfolioCoinsModel> coinList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: SfCircularChart(
        legend: const Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.left,
        ),
        tooltipBehavior: tooltipBehavior,
        series: <CircularSeries>[
          PieSeries<PortfolioCoinsModel, String>(
            dataSource: coinList,
            xValueMapper: (PortfolioCoinsModel data, _) => '${data.symbol.toUpperCase()} : ${data.quantity}',
            yValueMapper: (PortfolioCoinsModel data, _) => double.parse(data.totalSpent),
            dataLabelMapper: (PortfolioCoinsModel data, _) => data.symbol.toUpperCase(),
            sortFieldValueMapper: (PortfolioCoinsModel data, _) => data.totalSpent, // Sort the data by totalSpent
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            onPointTap: (ChartPointDetails details) {
              final tappedCoin = coinList[details.pointIndex!];
              // Show a dialog with the coin's details
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: context.projectTheme!.primaryColor,
                  title: Row(
                    children: [
                      Text(tappedCoin.symbol.toUpperCase()), // Coin symbol
                      const Spacer(),
                      Image.network(
                        tappedCoin.imageUrl, // Coin's image
                        height: 45,
                        width: 45,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  contentTextStyle: TextStyle(
                    color: context.isDarkMode
                        ? ProjectCustomColors.mWhitePrimary
                        : ProjectCustomColors.bgColor,
                  ),
                  content: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.mLocalizations.quantity),
                          const SizedBox(height: 10),
                          Text(context.mLocalizations.totalSpent),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tappedCoin.quantity),
                          const SizedBox(height: 10),
                          Text('\$ ${tappedCoin.totalSpent}'),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(), // Close the dialog
                      child: Text(
                        context.mLocalizations.cancel,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? ProjectCustomColors.mYellow
                              : ProjectCustomColors.mPinkPrimary,
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
      ),
    );
  }
}
