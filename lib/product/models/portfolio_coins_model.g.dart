// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_coins_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioCoinsModel _$PortfolioCoinsModelFromJson(Map<String, dynamic> json) =>
    PortfolioCoinsModel(
      dateTime: json['dateTime'] as String,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as String,
      symbol: json['symbol'] as String,
      totalSpent: json['totalSpent'] as String,
      uid: json['uid'] as String,
      currentValue: json['currentValue'] as String?,
      priceChange24H: (json['priceChange24H'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PortfolioCoinsModelToJson(
        PortfolioCoinsModel instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'quantity': instance.quantity,
      'symbol': instance.symbol,
      'totalSpent': instance.totalSpent,
      'uid': instance.uid,
      'currentValue': instance.currentValue,
      'priceChange24H': instance.priceChange24H,
    };
