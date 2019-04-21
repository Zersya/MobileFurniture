import 'package:flutter/material.dart';
import 'package:furniture_app/blocs/authentication/auth.dart';
import 'package:furniture_app/blocs/login/login.dart';
import 'package:furniture_app/screens/splash/splash_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  final AuthBloc authBloc;

  const RegisterScreen({Key key, this.authBloc}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  LoginBloc loginBloc;
  AuthBloc authBloc;

  var _formKey = GlobalKey<FormState>();
  var _pageController = PageController();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _passwordConfController = TextEditingController();
  var _nameController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _address_1Controller = TextEditingController();
  var _address_2Controller = TextEditingController();
  var _cityController = TextEditingController();
  var _zipCodeController = TextEditingController();
  var _emailController = TextEditingController();

  @override
  void initState() {
    authBloc = widget.authBloc;
    loginBloc = LoginBloc(authBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(223, 211, 195, 1),
      body: Container(
        child: PageView(
          controller: _pageController,
          pageSnapping: true,
          children: <Widget>[
            step_1Register(),
            step_2Register(),
            step_3Register()
          ],
        ),
      ),
    );
  }

  Widget buttonSubmit() {
    return BlocListener(
        bloc: loginBloc,
        listener: (BuildContext context, LoginState state) {
          if (state is RegisterFailed) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
          if (state is RegisterSuccess) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder(
          bloc: loginBloc,
          builder: (BuildContext context, LoginState state) {
            if (state is LoadingLogin) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(199, 177, 152, 1)),
              ));
            } else {
              return Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    loginBloc.dispatch(SubmitRegister(
                        _usernameController.text,
                        _passwordController.text,
                        _nameController.text,
                        _phoneNumberController.text,
                        _address_1Controller.text,
                        _address_2Controller.text,
                        _cityController.text,
                        _zipCodeController.text,
                        _emailController.text));
                  },
                  child: SizedBox(
                    width: 70,
                    height: 50,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(131, 132, 105, 1),
                            shape: BoxShape.circle),
                        child: Icon(
                          MdiIcons.check,
                          color: Colors.white,
                        )),
                  ),
                ),
              );
            }
          },
        ));
  }

  Widget buttonNext() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {
          _pageController.nextPage(
              curve: Curves.easeInOut, duration: Duration(milliseconds: 1100));
        },
        child: SizedBox(
          width: 70,
          height: 50,
          child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(131, 132, 105, 1),
                  shape: BoxShape.circle),
              child: Icon(
                MdiIcons.arrowRight,
                color: Colors.white,
              )),
        ),
      ),
    );
  }

  Widget step_1Register() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Step-1',
              style: TextStyle(
                  fontSize: 42.0,
                  fontFamily: 'Roboto',
                  shadows: [
                    Shadow(color: Colors.black, blurRadius: 0.5),
                    Shadow(color: Colors.black87, blurRadius: 0.5)
                  ],
                  color: Color.fromRGBO(131, 132, 105, 1),
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Username',
              ),
              validator: ((val) {
                if (val.isEmpty) return 'Masukan Username anda';
              }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Password',
              ),
              validator: (val) {
                if (val.isEmpty) return 'Masukan Password anda';
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _passwordConfController,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Password Konfirmasi',
              ),
              validator: (val) {
                if (val.isEmpty) return 'Masukan Password anda';
                if (_passwordController.text.toString() !=
                    _passwordConfController.text.toString()) {
                  return 'Password konfirmasi tidaklah sama';
                }
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          buttonNext()
        ],
      ),
    );
  }

  Widget step_2Register() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Step-2',
              style: TextStyle(
                  fontSize: 42.0,
                  fontFamily: 'Roboto',
                  shadows: [
                    Shadow(color: Colors.black, blurRadius: 0.5),
                    Shadow(color: Colors.black87, blurRadius: 0.5)
                  ],
                  color: Color.fromRGBO(131, 132, 105, 1),
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Nama',
              ),
              validator: ((val) {
                if (val.isEmpty) return 'Masukan Nama anda';
              }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Nomor Handphone',
              ),
              validator: ((val) {
                if (val.isEmpty) return 'Masukan Nomor Handphone anda';
              }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Email',
              ),
              validator: (val) {
                if (val.isEmpty) return 'Masukan Email anda';
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          buttonNext()
        ],
      ),
    );
  }

  Widget step_3Register() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Step-3',
              style: TextStyle(
                  fontSize: 42.0,
                  fontFamily: 'Roboto',
                  shadows: [
                    Shadow(color: Colors.black, blurRadius: 0.5),
                    Shadow(color: Colors.black87, blurRadius: 0.5)
                  ],
                  color: Color.fromRGBO(131, 132, 105, 1),
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _address_1Controller,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Alamat 1',
              ),
              validator: ((val) {
                if (val.isEmpty) return 'Masukan Alamat 1 anda';
              }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _address_2Controller,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Alamat 2',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Kota',
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _zipCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Kode Pos',
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          buttonSubmit()
        ],
      ),
    );
  }
}
