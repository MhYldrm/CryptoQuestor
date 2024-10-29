import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'earn_model.g.dart';

List<EarnModel> earnModelFromJson(String str) =>
    List<EarnModel>.from(json.decode(str).map((x) => EarnModel.fromJson(x)));

String coinModelToJson(List<EarnModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
final class EarnModel {

  final String title;
  final String imageUrl;
  final String exchangeIconUrl;
  final String exchangeName;
  final String dateTime;
  final String description;
  final String missions;
  final String refLink;
  final String missionsLink;

  EarnModel({
    required this.title,
    required this.imageUrl,
    required this.exchangeIconUrl,
    required this.exchangeName,
    required this.dateTime,
    required this.description,
    required this.missions,
    required this.refLink,
    required this.missionsLink,
  });

  factory EarnModel.fromJson(Map<String, dynamic> json) => _$EarnModelFromJson(json);

  Map<String, dynamic> toJson() => _$EarnModelToJson(this);
}
