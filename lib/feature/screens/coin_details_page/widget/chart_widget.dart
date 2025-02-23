/// [itemChart] Indicates information of coin price chart
/// [trackballBehavior] The trackball feature is a tool that displays a tooltip for data points closest to the point you touched in the chart area.
/// [time] The data for the chart on the relevant date.
/// [low] The lowest value in the chart on the relevant date.
/// [high] The highest value in the chart on the relevant date.
/// [open] The opening value of the chart on the relevant date.
/// [close] The closing value of the chart on the relevant date.
/// [Colors.green] If the close is higher, the candle on the chart will be green.
/// [Colors.red] If the close is lower, the candle on the chart will be red.
///
part of '../coin_details_page.dart';

final class ChartWidget extends StatelessWidget {
  const ChartWidget(
      {super.key, required this.itemChart, required this.trackballBehavior});

  final List<ChartModel>? itemChart;
  final TrackballBehavior? trackballBehavior;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ApplicationSize.size250.value,
      width: double.infinity,
      child: SfCartesianChart(
        trackballBehavior: trackballBehavior,
        zoomPanBehavior:
            ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x),
        primaryXAxis: CategoryAxis(
          labelStyle: TextStyle(
            color: context.isDarkMode
                ? CustomColors.mGreyPrimary
                : CustomColors.bgcolor,
            fontSize: ApplicationSize.xxSmall.value,
            fontWeight: FontWeight.w300,
          ),
        ),
        primaryYAxis: NumericAxis(
          labelStyle: TextStyle(
            color: context.isDarkMode
                ? CustomColors.mGreyPrimary
                : CustomColors.bgcolor,
            fontSize: ApplicationSize.xxSmall.value,
            fontWeight: FontWeight.w300,
          ),
        ),
        series: <CandleSeries>[
          CandleSeries<ChartModel, int>(
            enableSolidCandles: true,
            enableTooltip: true,
            bullColor: Colors.green,
            bearColor: Colors.red,
            dataSource: itemChart,
            xValueMapper: (ChartModel sales, _) => sales.time,
            lowValueMapper: (ChartModel sales, _) => sales.low,
            highValueMapper: (ChartModel sales, _) => sales.high,
            openValueMapper: (ChartModel sales, _) => sales.open,
            closeValueMapper: (ChartModel sales, _) => sales.close,
            animationDuration: ApplicationSize.xsLarge.value,
          )
        ],
      ),
    );
  }
}
