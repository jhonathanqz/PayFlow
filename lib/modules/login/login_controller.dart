import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();
  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      final user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl,
      );
      authController.setUser(context, user);
      print(response);
    } catch (error) {
      authController.setUser(context, null);
      print(error);
    }
  }

  Future<GoogleSignInAccount?> signOut(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await _googleSignIn.signOut();
      _googleSignIn.disconnect();
      final response =  _googleSignIn.disconnect();
      //await _googleSignIn.disconnect();
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
     print('**Fiz o signOut. ${response.toString()}');
    } catch (error) {
      authController.setUser(context, null);
      print('Erro ao realizar signOut. Erro recebido: $error');
    }
  }
}
