import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:furniture_app/models/response.dart';
import 'package:test_api/test_api.dart';
import 'dart:convert';

void main() {
  const url = 'https://harpah-app.herokuapp.com';
  test('Post Login', () async {
    await _login(url + '/api/auth/login').then((val) {
      print(val.token);
    });
  });
}

_login(url) async {
  final response = await http
      .post(url, body: {'username': 'zeinersyad', 'password': '123456'});
  var data = json.decode(response.body);

  return Response.fromJson(data);
}

_sharedPreferences(token, str) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (str == 'get') {
    token = prefs.getString('TOKEN_LOGIN');
    return token;
  } else if (str == 'set') await prefs.setString('TOKEN_LOGIN', token);
}
