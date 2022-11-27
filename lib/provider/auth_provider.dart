import 'package:bayt_test_app/model/exceptions/auth_exceptions.dart';
import 'package:bayt_test_app/model/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { idle, loading, authenticated, failure }

class AuthProvider extends ChangeNotifier {
  final _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AuthStatus authStatus = AuthStatus.idle;
  String? errorMsg;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    try {
      errorMsg = null;
      authStatus = AuthStatus.loading;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      final hasAuthenticated = await _authService.loginViaEmailAndPassword(
          emailController.text, passwordController.text);
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
