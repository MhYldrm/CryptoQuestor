import 'dart:convert';

List<EarnModel> earnModelFromJson(String str) =>
    List<EarnModel>.from(json.decode(str).map((x) => EarnModel.fromJson(x)));

String coinModelToJson(List<EarnModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EarnModel {
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

  String title;
  String imageUrl;
  String exchangeIconUrl;
  String exchangeName;
  String dateTime;
  String description;
  String missions;
  String refLink;
  String missionsLink;

  factory EarnModel.fromJson(Map<String, dynamic> map) => EarnModel(
    imageUrl: map["imageUrl"],
    title: map["title"],
    exchangeIconUrl: map["exchangeIconUrl"],
    exchangeName: map["exchangeName"],
    dateTime: map["dateTime"],
    description: map["description"],
    missions: map["missions"],
    refLink: map["refLink"],
    missionsLink: map["missionsLink"],
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['exchangeIconUrl'] = exchangeIconUrl;
    data['exchangeName'] = exchangeName;
    data['dateTime'] = dateTime;
    data['description'] = description;
    data['missions'] = missions;
    data['refLink'] = refLink;
    data['missionsLink'] = missionsLink;
    return data;
  }
}
