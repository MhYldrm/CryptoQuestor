import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'gecko_model_sparkline_in_7d_model.dart';

part 'gecko_model.g.dart';

/// [GeckoModel] Represents a model for cryptocurrency data, including price and market information.
/// It includes the coin's symbol, current price, market cap, volume, and other relevant statistics.
///
@JsonSerializable()
final class GeckoModel extends Equatable {
  const GeckoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCapRank,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.marketCapChangePercentage24H,
    required this.sparklineIn7D,
  });

  final String id; // Unique identifier for the coin
  final String symbol; // Symbol of the coin (e.g., BTC, ETH)
  final String name; // Name of the coin (e.g., Bitcoin, Ethereum)
  final String image; // URL of the coin's image/logo
  final double currentPrice; // Current price of the coin
  final int marketCapRank; // Market capitalization rank of the coin
  final double totalVolume; // Total volume of the coin traded
  final double high24H; // Highest price in the last 24 hours
  final double low24H; // Lowest price in the last 24 hours
  final double? priceChange24H; // Price change in the last 24 hours
  final double?
      marketCapChangePercentage24H; // Market cap change percentage in the last 24 hours
  final GeckoModelSpaklineIn7DModel sparklineIn7D; // Price trend in the last 7 days

  factory GeckoModel.fromJson(Map<String, dynamic> json) =>
      _$GeckoModelFromJson(json);

  @override
  // Override Equatable to compare instances based on their properties.
  List<Object?> get props => [
        id,
        symbol,
        name,
        image,
        currentPrice,
        marketCapRank,
        totalVolume,
        high24H,
        low24H,
        priceChange24H,
        marketCapChangePercentage24H,
        sparklineIn7D
      ];
}
