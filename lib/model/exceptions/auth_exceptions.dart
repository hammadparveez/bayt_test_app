class BaseException implements Exception {
  final String? code;
  final String? message;
  BaseException({this.code, this.message});
}

class UserNotFoundException extends BaseException {
  UserNotFoundException({super.message = 'Sorry, No such user exists'});
}

class EmailAlreadyExistsException extends BaseException {
  EmailAlreadyExistsException(
      {super.message = 'Email you entered already Exists'});
}

class WrongPasswordException extends BaseException {
  WrongPasswordException({super.message = 'Password you entered is incorrect'});
}

class WeakPasswordException extends BaseException {
  WeakPasswordException({super.message = 'Please enter a strong password'});
}

class UserSignedOutException extends BaseException {
  UserSignedOutException({super.message = 'You have been signed out'});
}

class SomethingWentWrongException extends BaseException {
  SomethingWentWrongException(
      {super.message = 'Oops, There was something wrong'});
}
