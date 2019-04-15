import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class CheckingAuth extends AuthEvent {
  @override
  String toString() {
  return 'CheckingAuth';
   }
}

class Authentication extends AuthEvent {
  final String token;

  Authentication(this.token);

  @override
  String toString() {
  return 'Authentication';
   }
}