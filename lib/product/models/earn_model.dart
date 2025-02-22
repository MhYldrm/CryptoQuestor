import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'earn_model.g.dart';

@JsonSerializable()
final class EarnModel {
  final String title;  // Title of the earning opportunity
  final String imageUrl;  // URL of the image associated with the earning opportunity
  final String exchangeIconUrl;  // URL of the exchange icon
  final String exchangeName;  // Name of the exchange
  final String dateTime;  // Date and time of the earning event
  final String description;  // Description of the earning opportunity
  final String missions;  // Description of the missions
  final String refLink;  // Referral link for the opportunity
  final String missionsLink;  // Link to the missions page

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

  /// Factory constructor to create an [EarnModel] from a JSON map.
  factory EarnModel.fromJson(Map<String, dynamic> json) => _$EarnModelFromJson(json);

  /// Converts the [EarnModel] instance to a JSON map.
  Map<String, dynamic> toJson() => _$EarnModelToJson(this);
}
/// Converts a JSON string to a list of [EarnModel] objects.
List<EarnModel> earnModelFromJson(String str) =>
    List<EarnModel>.from(json.decode(str).map((x) => EarnModel.fromJson(x)));

/// Converts a list of [EarnModel] objects to a JSON string.
String coinModelToJson(List<EarnModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));