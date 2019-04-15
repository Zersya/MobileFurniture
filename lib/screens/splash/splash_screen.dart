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
  AuthBloc _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _authBloc,
      builder: (BuildContext context, AuthState state) {
        print(state);
        return BlocProvider(
            bloc: _authBloc,
            child: LoginScreen(),
          );
        if (state is AuthInitial) {
          _authBloc.dispatch(CheckingAuth());
          return Scaffold(
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'HARPA',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 55,
                      fontFamily: 'DancingScript',
                      color: Colors.brown),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
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
    // TODO: implement dispose
    _authBloc.dispose();
    super.dispose();
  }
}
