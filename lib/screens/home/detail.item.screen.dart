import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/blocs/Items/items.dart';
import 'package:furniture_app/blocs/authentication/auth.dart';
import 'package:furniture_app/blocs/cart/cart.dart';
import 'package:furniture_app/models/item.dart';

class DetailItemScreen extends StatefulWidget {
  final Item item;
  final ItemsBloc itemsBloc;
  const DetailItemScreen({Key key, this.item, this.itemsBloc})
      : super(key: key);
  @override
  _DetailItemScreenState createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  AuthBloc authBloc;
  List<Widget> listImages = new List();
  CartBloc cartBloc = CartBloc();
  String TOKEN;
  int quantity = 0;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.itemsBloc.dispatch(LoadItems(TOKEN));
      },
      child: BlocListener(
          bloc: cartBloc,
          listener: (BuildContext context, CartState state) {
            if (state is AddedItemToCart) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          child: BlocBuilder(
              bloc: authBloc,
              builder: (BuildContext context, AuthState _authState) {
                if (_authState is Authenticated) {
                  TOKEN = _authState.token;
                  return SizedBox(
                    height: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                          height: 300,
                          placeholder: 'images/wait.png',
                          image: widget.item.images[0].imageurl,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Positioned(
                          top: 280,
                          left: 0,
                          right: 0,
                          height: 250,
                          child: Align(
                              alignment: Alignment.center,
                              child: Card(
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            widget.item.name,
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        buildTable(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: buildRow(_authState)),
                                      ],
                                    ),
                                  ))),
                        )
                      ],
                    ),
                  );
                }
              })),
    );
  }

  Row buildRow(Authenticated _authState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          'Rp. ' +
              FlutterMoneyFormatter(amount: widget.item.price.toDouble())
                  .output
                  .nonSymbol,
          style: TextStyle(fontSize: 18),
        ),
        BlocBuilder(
            bloc: cartBloc,
            builder: (context, state) {
              if (state is LoadingCart) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(199, 177, 152, 1)),
                ));
              }
              return FlatButton.icon(
                color: Colors.brown,
                textColor: Colors.white,
                icon: Icon(
                  Icons.add_shopping_cart,
                ),
                label: Text('Tambah'),
                onPressed: () {
                  cartBloc.dispatch(
                      AddItemToCart(widget.item, 1, _authState.token));
                },
              );
            }),
      ],
    );
  }

  Table buildTable() {
    return Table(
      children: [
        TableRow(children: [
          Text(
            'Stok : ',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            widget.item.quantity.toString() + ' set',
            style: TextStyle(fontSize: 18),
          ),
        ]),
        TableRow(children: [
          Text(
            'Kategori : ',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            widget.item.category,
            style: TextStyle(fontSize: 18),
          ),
        ])
      ],
    );
  }
}
