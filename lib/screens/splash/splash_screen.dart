import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/blocs/authentication/auth.dart';
import '../login/login_screen.dart';
import '../home//home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthBloc _authBloc;
  @override
  void initState() {
    _authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _authBloc,
      builder: (BuildContext context, AuthState state) {
        if (state is AuthInitial) {
          _authBloc.dispatch(CheckingAuth());
          return Scaffold(
            backgroundColor: Color.fromRGBO(223, 211, 195, 1),
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Harpa Furniture',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      fontFamily: 'DancingScript',
                      color: Color.fromRGBO(131, 132, 105, 1)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(199, 177, 152, 1)),
          ))
              ],
            ),
          ));
        }
        if (state is Authenticated) {
          return BlocProvider(
            bloc: _authBloc,
            child: Home(),
          );
        }
        if (state is NotAuthenticated) {
          return BlocProvider(
            bloc: _authBloc,
            child: LoginScreen(),
          );
        }
        
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
