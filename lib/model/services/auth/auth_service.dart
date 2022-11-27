import 'package:bayt_test_app/model/exceptions/auth_exceptions.dart';
import 'package:bayt_test_app/model/repository/auth_repo.dart';

class AuthService {
  final _authRepo = AuthRepo();

  BaseException _handleAuthError(String? code) {
    switch (code) {
      case 'weak-password':
        throw WeakPasswordException();
      case 'wrong-password':
        throw WeakPasswordException();
      case 'email-already-in-use':
        throw WeakPasswordException();

      default:
        throw SomethingWentWrongException();
    }
  }

  Future<bool> loginViaEmailAndPassword(String email, String password) async {
    try {
      return await _authRepo.loginViaEmailAndPassword(email, password);
    } on BaseException catch (e) {
      throw _handleAuthError(e.code);
    }
  }
}
