import 'package:bayt_test_app/model/exceptions/auth_exceptions.dart';
import 'package:bayt_test_app/model/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { idle, loading, authenticated, failure }

class AuthProvider extends ChangeNotifier {
  final _authService = AuthService();
  
  AuthStatus authStatus = AuthStatus.idle;
  String? errorMsg;
  

  void login(String email, String password) async {
    try {
      errorMsg = null;
      authStatus = AuthStatus.loading;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      final hasAuthenticated = await _authService.loginViaEmailAndPassword(email,password);
      authStatus =
          hasAuthenticated ? AuthStatus.authenticated : AuthStatus.failure;
    } on BaseException catch (e) {
      authStatus = AuthStatus.failure;

      debugPrint('Exception Provider ${e.message}');
      errorMsg = e.message;
    }
    notifyListeners();
  }
}
