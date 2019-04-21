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

class SubmitRegister extends LoginEvent {
  final String username, password, name, phoneNumber, address_1, address_2, city, postCode, email;

  SubmitRegister(this.username, this.password, this.name, this.phoneNumber, this.address_1, this.address_2, this.city, this.postCode, this.email);

  @override
  String toString() {
    return 'SubmitRegister';
  }
}
