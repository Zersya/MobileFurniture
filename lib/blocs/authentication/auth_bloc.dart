import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:furniture_app/models/response.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final url = 'https://harpah-app.herokuapp.com/';

  @override
  // TODO: implement initialState
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // TODO: implement mapEventToState
    if (event is Authentication) {
      yield* _settoken(event);
    }

    if (event is CheckingAuth) {
      yield* _gettoken();
    }
  }

  Stream<AuthState> _settoken(event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.setString('TOKEN_LOGIN', event.token);
    if (token != null)
      yield Authenticated(event.token);
    else
      yield NotAuthenticated('Token not found');
  }

  Stream<AuthState> _gettoken() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('TOKEN_LOGIN');
    var response = await http.get(url + 'api/customer/check', headers: {
      'Authorization': token,
    });
    var data = json.decode(response.body);
    var res = Response.fromJson(data);
    if (token != null && res.success) {
          yield Authenticated(token);
    } else
      yield NotAuthenticated(res.message);
  }
}
