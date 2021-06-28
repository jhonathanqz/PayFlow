import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();
  bool _isProcessing = false;

  final _streamController = StreamController<bool>();

  Sink<bool> get input => _streamController.sink;
  Stream<bool> get output => _streamController.stream;

  bool get isProcessing => _isProcessing;

  Future<void> googleSignIn(BuildContext context) async {
    _isProcessing = true;
    input.add(_isProcessing);

    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );

    try {
      GoogleSignInAccount? response = await _googleSignIn.signIn();

      UserModel user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl,
        email: response.email,
      );
      authController.setUser(context, user);
    } catch (error) {
      authController.setUser(context, null);
      debugPrint(error.toString());
    } finally {
      _isProcessing = false;
      input.add(_isProcessing);
    }
  }

  Future<GoogleSignInAccount?> signOut(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await GoogleSignIn(scopes: ['email']).signOut();
      await _googleSignIn.signOut();
      _googleSignIn.disconnect();
      //final response =  _googleSignIn.disconnect();
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
     print('**Fiz o signOut. ');
    } catch (error) {
      authController.setUser(context, null);
      print('Erro ao realizar signOut. Erro recebido: $error');
    }
  }

  dispose() {
    _streamController.close();
  }
}
