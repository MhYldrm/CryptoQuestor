import 'package:equatable/equatable.dart';

/// [ChartModel] represents a single data point for a chart, typically used in financial or stock market data.
/// It contains time and price information such as open, high, low, and close prices.
/// This model is used to store and compare financial data points over time.
final class ChartModel extends Equatable {
  final int time;  // Timestamp of the data point (Unix timestamp)
  final double open;  // Opening price of the asset at the start of the time period
  final double high;  // Highest price of the asset during the time period
  final double low;  // Lowest price of the asset during the time period
  final double close;  // Closing price of the asset at the end of the time period

  const ChartModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  /// Creates a [ChartModel] instance from a list of values (e.g., [time, open, high, low, close]).
  /// The list is expected to contain the data in a specific order.
  ///
  /// [value] A list containing the time, open, high, low, and close values.
  factory ChartModel.fromJson(List<dynamic> value) {
    return ChartModel(
      time: value[0] as int,
      open: value[1] as double,
      high: value[2] as double,
      low: value[3] as double,
      close: value[4] as double,
    );
  }

  @override
  // Overrides the Equatable package to compare objects based on these properties.
  List<Object?> get props => [time, open, high, low, close];
}
