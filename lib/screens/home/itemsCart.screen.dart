import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/blocs/authentication/auth.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:furniture_app/blocs/cart/cart.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemsCart extends StatefulWidget {
  final String TOKEN;

  const ItemsCart({Key key, this.TOKEN}) : super(key: key);
  @override
  _ItemsCartState createState() => _ItemsCartState();
}

class _ItemsCartState extends State<ItemsCart> {
  CartBloc cartBloc = CartBloc();
  AuthBloc authBloc;
  SlidableController slidableController = SlidableController();

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    cartBloc.dispatch(LoadCart(widget.TOKEN));
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: cartBloc,
        listener: (BuildContext context, CartState state) {
          if (state is SubmitedToOrder) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
          if (state is DeletedCart) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
            cartBloc.dispatch(LoadCart(widget.TOKEN));
          }
        },
        child: BlocBuilder(
          bloc: cartBloc,
          builder: (BuildContext context, CartState cartState) {
            print('cartState  : ' + cartState.toString());
            if (cartState is LoadedCart) {
              if (cartState.cart.itemsCart.length == 0)
                return Center(child: Text('Kamu belum memesan apapun'));
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Keranjang saya',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          buildListView(cartState),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Rp. ' +
                                        FlutterMoneyFormatter(
                                                amount: cartState.cart.price
                                                    .toDouble())
                                            .output
                                            .nonSymbol,
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                                  ),
                                  FloatingActionButton(
                                    backgroundColor: Colors.brown,
                                    child:
                                        Icon(Icons.check, color: Colors.white),
                                    onPressed: () {
                                      _neverSatisfied();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (cartState is SubmitedToOrder) {
              return Center(
                  child: Text('Keranjang sudah dipindahkan ke orderan'));
            } else {
              return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(199, 177, 152, 1)),
          ));
            }
          },
        ));
  }

  ListView buildListView(LoadedCart cartState) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cartState.cart.itemsCart.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          direction: Axis.horizontal,
          controller: slidableController,
          delegate: SlidableScrollDelegate(),
          actionExtentRatio: 0.25,
          child: Card(
            color: Color.fromRGBO(248, 239, 239, 1),
            child: ListTile(
              leading: FadeInImage.assetNetwork(
                height: 50,
                width: 80,
                placeholder: 'assets/wait.png',
                image: cartState.cart.itemsCart[index].id.images[0].imageurl,
                // image: 'https://picsum.photos/250?image=9',
                fit: BoxFit.fill,
              ),
              title: Text(cartState.cart.itemsCart[index].id.name),
              subtitle: Text(
                'Rp. ' +
                    FlutterMoneyFormatter(
                            amount: cartState.cart.itemsCart[index].priceAll
                                .toDouble())
                        .output
                        .nonSymbol,
              ),
              trailing: Text(
                cartState.cart.itemsCart[index].quantity.toString() + ' set',
                style: TextStyle(fontSize: 21),
              ),
            ),
          ),
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => cartBloc.dispatch(DeleteCart(
                  widget.TOKEN, cartState.cart.itemsCart[index].id.id)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambahkan ke orderan'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Pesanan saat ini berada di keranjang.'),
                Text('\nTambahkan keranjang ke orderan ?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Ya'),
              onPressed: () {
                cartBloc.dispatch(SubmitCart(widget.TOKEN));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
