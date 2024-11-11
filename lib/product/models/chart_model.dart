import 'package:equatable/equatable.dart';

/// [ChartModel] Represents a single data point for a chart, typically used in financial or stock market data.
/// It contains time and price information such as open, high, low, and close prices.
final class ChartModel extends Equatable {
  final int time;  // Timestamp of the data point
  final double open;  // Opening price
  final double high;  // Highest price
  final double low;  // Lowest price
  final double close;  // Closing price

  const ChartModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  /// Creates a [ChartModel] instance from a list of values (e.g., [time, open, high, low, close]).
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
  List<Object?> get props => [time, open, high, low, close];
}