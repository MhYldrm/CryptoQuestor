import 'dart:convert';
import 'package:equatable/equatable.dart';

/// [GeckoCoinModels] A utility class for handling JSON serialization and deserialization of [GeckoModel] objects.
/// It provides methods to convert a JSON string into a list of [GeckoModel] objects and vice versa.
class GeckoCoinModels {
  /// Converts a JSON string into a list of [GeckoModel] objects.
  /// [str] The JSON string representing a list of GeckoModel objects.
  static List<GeckoModel> fromJsonList(String str) =>
      List<GeckoModel>.from(json.decode(str).map((x) => GeckoModel.fromJson(x)));

  /// Converts a list of [GeckoModel] objects into a JSON string.
  /// [data] The list of [GeckoModel] objects to be converted into JSON.
  static String toJsonList(List<GeckoModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

/// [GeckoModel] Represents a model for cryptocurrency data, including price and market information.
/// It includes the coin's symbol, current price, market cap, volume, and other relevant statistics.
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

  /// Creates a [GeckoModel] instance from a JSON map.
  /// [json] The JSON map containing the coin's data.
  factory GeckoModel.fromJson(Map<String, dynamic> json) => GeckoModel(
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
    sparklineIn7D: SparklineIn7D.fromJson(json["sparkline_in_7d"]),
  );

  final String id;  // Unique identifier for the coin
  final String symbol;  // Symbol of the coin (e.g., BTC, ETH)
  final String name;  // Name of the coin (e.g., Bitcoin, Ethereum)
  final String image;  // URL of the coin's image/logo
  final double currentPrice;  // Current price of the coin
  final int marketCapRank;  // Market capitalization rank of the coin
  final double totalVolume;  // Total volume of the coin traded
  final double high24H;  // Highest price in the last 24 hours
  final double low24H;  // Lowest price in the last 24 hours
  final double? priceChange24H;  // Price change in the last 24 hours
  final double? marketCapChangePercentage24H;  // Market cap change percentage in the last 24 hours
  final SparklineIn7D sparklineIn7D;  // Price trend in the last 7 days

  /// Converts the [GeckoModel] instance to a JSON map.
  /// Returns a map that represents the coin's data in JSON format.
  Map<String, dynamic> toJson() => {
    'id': id,
    'symbol': symbol,
    'name': name,
    'image': image,
    'current_price': currentPrice,
    'market_cap_rank': marketCapRank,
    'total_volume': totalVolume,
    'high_24h': high24H,
    'low_24h': low24H,
    'price_change_24h': priceChange24H,
    'market_cap_change_percentage_24h': marketCapChangePercentage24H,
    'sparkline_in_7d': sparklineIn7D.toJson(),
  };

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

/// [SparklineIn7D] Represents the price trend of a coin over the last 7 days.
/// This model contains a list of prices over the last 7 days.
class SparklineIn7D {
  SparklineIn7D({
    required this.price,
  });

  /// Creates a [SparklineIn7D] instance from a JSON map.
  /// [json] The JSON map containing the price data.
  factory SparklineIn7D.fromJson(Map<String, dynamic> json) => SparklineIn7D(
    price: List<double>.from(json["price"].map((x) => x?.toDouble())),
  );

  final List<double> price;  // List of prices over the last 7 days

  /// Converts the [SparklineIn7D] instance to a JSON map.
  /// Returns a map representing the price trend in JSON format.
  Map<String, dynamic> toJson() => {
    "price": List<dynamic>.from(price.map((x) => x)),
  };
}
