import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {}

class SubmitLogin extends LoginEvent {
  final String username, password;
  final GlobalKey<ScaffoldState> scaffoldKey;

  SubmitLogin(this.username, this.password, this.scaffoldKey);

  @override
  String toString() {
    return 'SubmitLogin';
  }
}
