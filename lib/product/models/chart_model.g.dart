// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

/// Creates a [ChartModel] instance from a list of values (e.g., [time, open, high, low, close]).
/// The list is expected to contain the data in a specific order.
///
/// [value] A list containing the time, open, high, low, and close values.
/// The values should be ordered as follows:
/// - value[0]: Time (timestamp or period)
/// - value[1]: Open price (price at the start of the time period)
/// - value[2]: High price (highest price during the time period)
/// - value[3]: Low price (lowest price during the time period)
/// - value[4]: Close price (price at the end of the time period)
ChartModel _$ChartModelFromJson(List<dynamic> value) => ChartModel(
      // Time represents the timestamp or period, typically an integer representing Unix time.
      time: value[0] as int,

      // Open price is the price of the asset at the start of the given time period (e.g., a day or an hour).
      open: value[1] as double,

      // High price is the highest value reached by the asset during the given time period.
      high: value[2] as double,

      // Low price is the lowest value reached by the asset during the given time period.
      low: value[3] as double,

      // Close price is the final price of the asset at the end of the given time period.
      close: value[4] as double,
    );

Map<String, dynamic> _$ChartModelToJson(ChartModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
    };
