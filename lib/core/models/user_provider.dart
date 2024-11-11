import 'package:flutter/material.dart';
import 'user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(name: '', email: '', password: '');

  User get user => _user;

  void setUserData({String? name, String? email, String? password}) {
    _user = User(
      name: name ?? _user.name,
      email: email ?? _user.email,
      password: password ?? _user.password,
    );
    notifyListeners();
  }
}
