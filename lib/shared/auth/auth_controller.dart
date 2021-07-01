import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/utils/navigator.dart';
import 'package:payflow/shared/utils/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(
    BuildContext context,
    UserModel? user,
  ) {
    if (user != null) {
      saveUser(user);
      _user = user;
      push(
        context,
        "/home",
        replace: true,
        arguments: user,
      );
    } else {
      push(
        context,
        "/login",
        replace: true,
      );
    }
  }

  Future<void> saveUser(UserModel user) async {
    Prefs.setString('user', user.toJson());
  }

  Future<void> logout() async {
    Prefs.setString('user', "");
    await GoogleSignIn(scopes: ['email']).signOut();
  }

  Future<void> deleteUser() async {
    final instance = await SharedPreferences.getInstance();
    instance.remove("user");
  }

  Future<void> currentUser(BuildContext context) async {
    String result = await Prefs.getString('user');

    if (result.isNotEmpty) {
      setUser(
        context,
        UserModel.fromJson(result),
      );
    } else {
      setUser(
        context,
        null,
      );
    }
  }

  Future<UserModel> getCurrentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    return UserModel.fromJson(instance.get("user").toString());
  }
}
