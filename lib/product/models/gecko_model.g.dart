// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gecko_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeckoModel _$GeckoModelFromJson(Map<String, dynamic> json) => GeckoModel(
      id: json["id"],
      symbol: json["symbol"],
      name: json["name"],
      image: json["image"],
      currentPrice: json["current_price"].toDouble(),
      marketCapRank: json["market_cap_rank"],
      totalVolume: json["total_volume"].toDouble(),
      high24H: json["high_24h"].toDouble(),
      low24H: json["low_24h"].toDouble(),
      priceChange24H: json["price_change_24h"]?.toDouble(),
      marketCapChangePercentage24H:
      json["market_cap_change_percentage_24h"]?.toDouble(),
      sparklineIn7D: GeckoModelSpaklineIn7DModel.fromJson(json["sparkline_in_7d"]),
    );

Map<String, dynamic> _$GeckoModelToJson(GeckoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'image': instance.image,
      'currentPrice': instance.currentPrice,
      'marketCapRank': instance.marketCapRank,
      'totalVolume': instance.totalVolume,
      'high24H': instance.high24H,
      'low24H': instance.low24H,
      'priceChange24H': instance.priceChange24H,
      'marketCapChangePercentage24H': instance.marketCapChangePercentage24H,
      'sparklineIn7D': instance.sparklineIn7D,
    };
