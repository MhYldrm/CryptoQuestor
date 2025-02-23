import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_model.g.dart';

/// [ChartModel] represents a single data point for a chart, typically used in financial or stock market data.
/// It contains time and price information such as open, high, low, and close prices.
/// This model is used to store and compare financial data points over time.
///
@JsonSerializable()
final class ChartModel extends Equatable {
  final int time; // Timestamp of the data point (Unix timestamp)
  final double
      open; // Opening price of the asset at the start of the time period
  final double high; // Highest price of the asset during the time period
  final double low; // Lowest price of the asset during the time period
  final double
      close; // Closing price of the asset at the end of the time period

  const ChartModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory ChartModel.fromJson(List<dynamic> value) =>
      _$ChartModelFromJson(value);

  @override
  // Overrides the Equatable package to compare objects based on these properties.
  List<Object?> get props => [time, open, high, low, close];
}
