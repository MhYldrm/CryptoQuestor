class ChartModel {
  int time;
  double? open;
  double? high;
  double? low;
  double? close;

  ChartModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory ChartModel.fromJson(List x) {
    return ChartModel(
      time: x[0],
      open: x[1],
      high: x[2],
      low: x[3],
      close: x[4],
    );
  }
}
