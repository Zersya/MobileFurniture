import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  String toString() {
    return 'AuthInitial';
  }
}

class LoadingAuth extends AuthState{
  @override
  String toString() {
  return 'LoadingAuth';
   }
}

class Authenticated extends AuthState {
  final String token;

  Authenticated(this.token);
  @override
  String toString() {
    return 'Authenticated';
  }
}

class NotAuthenticated extends AuthState {
  final String message;

  NotAuthenticated(this.message);
  @override
  String toString() {
    return 'NotAuthenticated';
  }
}
