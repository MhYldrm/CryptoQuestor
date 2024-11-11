import 'package:equatable/equatable.dart';

final class ChartModel extends Equatable {
  final int time;
  final double open;
  final double high;
  final double low;
  final double close;

  const ChartModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

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
