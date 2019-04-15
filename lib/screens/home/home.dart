import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/blocs/authentication/auth.dart';
import 'package:furniture_app/screens/home/transaction.screen.dart';
import 'grid.item.screen.dart';
import 'itemsCart.screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int selectedMenu = 0;
  AuthBloc authBloc;
  TabController tabController;

  static String TOKEN = "";

  @override
  void initState() {
    tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    authBloc = BlocProvider.of<AuthBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: authBloc,
        builder: (context, AuthState state) {
          if (state is Authenticated) {
            final widgetBody = [
              BlocProvider(
                      bloc: authBloc,
                      child: GridItems(
                        TOKEN: state.token,
                      ),
                    ),
                    ItemsCart(TOKEN: state.token),
                    TransactionOrder(TOKEN: state.token)
            ];
            return Scaffold(
              backgroundColor: Color.fromRGBO(223, 211, 195, 1),
                body: widgetBody[selectedMenu],
                bottomNavigationBar: BottomAppBar(
                  elevation: 5,
                  color: Colors.brown,
                  child: BottomNavigationBar(
                    backgroundColor: Color.fromRGBO(199,177,152,1),
                    selectedItemColor: Colors.black,
                    currentIndex: selectedMenu,
                    onTap: (i) {
                      setState(() {
                       selectedMenu = i; 
                      });
                    },
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), title: Text('Home')),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart), title: Text('Cart')),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.attach_money),
                          title: Text('Transaction'))
                    ],
                  ),
                ));
          }
        });
  }
}

class bodyTab extends StatelessWidget {
  final name;
  const bodyTab({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          children: <Widget>[Text(name)],
        ),
      ),
    );
  }
}

//
