// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earn_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarnModel _$EarnModelFromJson(Map<String, dynamic> json) => EarnModel(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      exchangeIconUrl: json['exchangeIconUrl'] as String,
      exchangeName: json['exchangeName'] as String,
      dateTime: json['dateTime'] as String,
      description: json['description'] as String,
      missions: json['missions'] as String,
      refLink: json['refLink'] as String,
      missionsLink: json['missionsLink'] as String,
    );

Map<String, dynamic> _$EarnModelToJson(EarnModel instance) => <String, dynamic>{
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'exchangeIconUrl': instance.exchangeIconUrl,
      'exchangeName': instance.exchangeName,
      'dateTime': instance.dateTime,
      'description': instance.description,
      'missions': instance.missions,
      'refLink': instance.refLink,
      'missionsLink': instance.missionsLink,
    };
