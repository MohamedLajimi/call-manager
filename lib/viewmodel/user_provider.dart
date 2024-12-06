// ignore_for_file: prefer_const_constructors

import 'package:call_me_app/database/database_helper.dart';
import 'package:call_me_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper;
  UserProvider(this._databaseHelper);

  User _user = User(
      id: '', name: '', email: '', password: '', phoneNumber: '', picture: '');

  User get user => _user;

  void setUser(User user) async {
    _user = user;
    notifyListeners();
  }

  Future<User?> fetchUserData() async {
    final user = await _databaseHelper.getCurrentUser();
    if (user != null) {
      setUser(user);
      return user;
    }
    return null;
  }

  void editCurrentUser({required User user}) {
    _databaseHelper.editCurrentUser(user: user);
    setUser(user);
  }
}
