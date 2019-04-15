import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class InitialLogin extends LoginState {
  @override
  String toString() {
    return 'InitalState';
  }
}

class LoadingLogin extends LoginState {
  @override
  String toString() {
    return 'LoadingLogin';
  }
}

class LoggedIn extends LoginState {
  @override
  String toString() {
    return 'LoggedIn';
  }
}

class LoginFailed extends LoginState {
  final message;

  LoginFailed(this.message);
  @override
  String toString() {
    return 'LoginFailed';
  }
}