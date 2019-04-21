import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/auth.dart';
import 'package:furniture_app/models/response.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final url = 'https://harpah-app.herokuapp.com/';
  final AuthBloc authBloc;

  LoginBloc(this.authBloc);

  @override
  LoginState get initialState => InitialLogin();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SubmitLogin) {
      yield* _login(url + 'api/auth/login', event);
    }

    if (event is SubmitRegister) {
      yield* _register(url + 'api/register', event);
    }
  }

  Stream<LoginState> _login(url, event) async* {
    yield LoadingLogin();
    final response = await http.post(url,
        body: {'username': event.username, 'password': event.password});
    var data = json.decode(response.body);
    var res = Response.fromJson(data);
    print(res.message);
    if (res.success) {
      authBloc.dispatch(Authentication(res.token));
      yield LoggedIn();
    } else {
      event.scaffoldKey.currentState
          .showSnackBar(SnackBar(content: new Text(res.message)));
      yield LoginFailed(res.message);
    }
  }

  Stream<LoginState> _register(url, SubmitRegister event) async* {
    yield LoadingLogin();
    final response = await http.post(url, body: {
      'username': event.username,
      'password': event.password,
      'name': event.name,
      'phoneNumber': event.phoneNumber,
      'address_1': event.address_1,
      'address_2': event.address_2,
      'city': event.city,
      'postCode': event.postCode,
      'email': event.email
    });
    var data = json.decode(response.body);
    var res = Response.fromJson(data);
    if (res.success) {
      authBloc.dispatch(Authentication(res.token));
      yield RegisterSuccess();
    } else {
      yield RegisterFailed(res.message);
    }
  }
}
