import 'package:flutter/material.dart';
import 'user_model.dart';

/// [UserProvider] manages the state of the user data and provides it
/// to the widgets that listen to it.
class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(name: '', email: '', password: '');

  // Gets the current user data
  UserModel get user => _user;

  // Updates the user data and notifies listeners
  void setUserData({String? name, String? email, String? password}) {
    _user = UserModel(
      name: name ?? _user.name,
      email: email ?? _user.email,
      password: password ?? _user.password,
    );
    notifyListeners();  // Notifies all listeners that the user data has changed
  }
}