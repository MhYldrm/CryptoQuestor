import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
final class UserModel {
  String name;
  String email;
  String password;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
  });
}