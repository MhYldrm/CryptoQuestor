import 'package:json_annotation/json_annotation.dart';

part 'portfolio_coins_model.g.dart';

/// [PortfolioCoinsModel] Represents a model for a cryptocurrency in the user's portfolio.
/// It contains information about the coin's name, quantity, total spent, and additional data such as current value and price change.
@JsonSerializable()
class PortfolioCoinsModel {
  final String dateTime;  // Date and time when the data was recorded
  final String imageUrl;  // URL of the coin's image/logo
  final String name;  // Name of the coin (e.g., Bitcoin, Ethereum)
  final String quantity;  // Quantity of the coin in the portfolio
  final String symbol;  // Symbol of the coin (e.g., BTC, ETH)
  final String totalSpent;  // Total amount spent on the coin
  final String uid;  // Unique identifier for the coin in the portfolio
  final String? currentValue;  // Current value of the coin in the portfolio (optional)
  final double? priceChange24H;  // Price change in the last 24 hours (optional)

  /// Constructor to create an instance of [PortfolioCoinsModel] with the provided values.
  PortfolioCoinsModel({
    required this.dateTime,
    required this.imageUrl,
    required this.name,
    required this.quantity,
    required this.symbol,
    required this.totalSpent,
    required this.uid,
    this.currentValue,
    this.priceChange24H,
  });

  /// Creates a copy of the current [PortfolioCoinsModel] instance with optional updated values.
  /// [dateTime], [imageUrl], [name], [quantity], [symbol], [totalSpent], [uid], and [priceChange24H] can be passed to update the fields.
  PortfolioCoinsModel copyWith({
    String? dateTime,
    String? imageUrl,
    String? name,
    String? quantity,
    String? symbol,
    String? totalSpent,
    String? uid,
    double? priceChange24H,
  }) {
    return PortfolioCoinsModel(
      dateTime: dateTime ?? this.dateTime,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      symbol: symbol ?? this.symbol,
      totalSpent: totalSpent ?? this.totalSpent,
      priceChange24H: priceChange24H ?? this.priceChange24H,
      uid: uid ?? this.uid,
    );
  }

  /// Creates an instance of [PortfolioCoinsModel] from a JSON map.
  /// [json] The JSON map containing the coin's data.
  factory PortfolioCoinsModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioCoinsModelFromJson(json);

  /// Converts the [PortfolioCoinsModel] instance into a JSON map.
  /// Returns a map that represents the coin's data in JSON format.
  Map<String, dynamic> toJson() => _$PortfolioCoinsModelToJson(this);
}
