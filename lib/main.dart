import 'package:flutter/material.dart';
import 'package:furniture_app/screens/splash/splash_screen.dart';
import 'screens/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Furniture',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        primarySwatch: Colors.blue, fontFamily: 'Roboto'
      ),
      home: SplashScreen(),
    );
  }
}