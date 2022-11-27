import 'package:bayt_test_app/model/exceptions/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;

  Future<bool> loginViaEmailAndPassword(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await _createUser(email, password);
      }
      throw BaseException(code: e.code);
    }
  }

  _createUser(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user.user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      throw BaseException(code: e.code);
    }
  }
}
