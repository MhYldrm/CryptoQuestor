import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// [UserModel] Represents a user with basic information such as name, email, and password.
/// It is used for storing and managing user data, typically during registration or authentication.
@JsonSerializable()
final class UserModel {
  // The user's password (should be securely stored)

  /// Constructor to create an instance of [UserModel] with the provided values.
  UserModel({
    required this.name,
    required this.email,
    required this.password,
  });
  String name; // The user's name
  String email; // The user's email address
  String password;
}
