import 'package:http/http.dart' as http;
import 'package:furniture_app/models/item.dart';
import 'package:test_api/test_api.dart';
import 'dart:convert';

void main() {
  const url = 'https://harpah-app.herokuapp.com';
  const TOKEN ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiQ3VzdG9tZXIiLCJ1c2VybmFtZSI6InplaW5lcnN5YWQiLCJfaWQiOiI1Yzk4ODI0M2ViZmU2MTAwMjBkNWEyNmYiLCJpYXQiOjE1NTUxNDEyNjUsImV4cCI6MTU1NTIyNzY2NX0.JHfaWpKL82ez3AfvPvkXjHAsh50rfJMKWE_B2EOuZoc';
  test('Get Data', () async {
    var res = await http.get(url, headers: {'Authorization': TOKEN});
    if (res.statusCode == 200) {
      List rawData = json.decode(res.body).cast<Map<String, dynamic>>();
      List<Item> items =
      rawData.map<Item>((json) => Item.fromJson(json)).toList();
      print(items);
    } else {
    }
  });
}


