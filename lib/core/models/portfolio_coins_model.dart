import 'package:json_annotation/json_annotation.dart';

part 'portfolio_coins_model.g.dart';

@JsonSerializable()
class PortfolioCoinsModel {
  final String dateTime;
  final String imageUrl;
  final String name;
  final String quantity;
  final String symbol;
  final String totalSpent;
  final String uid;

  PortfolioCoinsModel({
    required this.dateTime,
    required this.imageUrl,
    required this.name,
    required this.quantity,
    required this.symbol,
    required this.totalSpent,
    required this.uid,
  });

  //
  PortfolioCoinsModel copyWith({
    String? dateTime,
    String? imageUrl,
    String? name,
    String? quantity,
    String? symbol,
    String? totalSpent,
    String? uid,
  }) {
    return PortfolioCoinsModel(
      dateTime: dateTime ?? this.dateTime,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      symbol: symbol ?? this.symbol,
      totalSpent: totalSpent ?? this.totalSpent,
      uid: uid ?? this.uid,
    );
  }


  // To create object from JSON
  factory PortfolioCoinsModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioCoinsModelFromJson(json);

  // To convert object to JSON
  Map<String, dynamic> toJson() => _$PortfolioCoinsModelToJson(this);
}