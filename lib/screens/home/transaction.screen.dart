import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:furniture_app/blocs/transaction/transaction.dart';

class TransactionOrder extends StatefulWidget {
  final String TOKEN;

  const TransactionOrder({Key key, this.TOKEN}) : super(key: key);
  @override
  _TransactionOrderState createState() => _TransactionOrderState();
}

class _TransactionOrderState extends State<TransactionOrder> {
  TransactionBloc transactionBloc = TransactionBloc();

  @override
  void initState() {
    transactionBloc.dispatch(LoadTransaction(widget.TOKEN));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: transactionBloc,
      builder: (BuildContext context, TransactionState state) {
        if (state is LoadingTransaction) {
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(199, 177, 152, 1)),
          ));
        } else if (state is LoadedTransaction) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Transaksi saya',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: state.list.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Card(
                        elevation: 5,
                        child: Container(
                          color: Color.fromRGBO(199, 177, 152, .5),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: Color.fromRGBO(199, 177, 152, 1),
                              child: Text(
                                (i + 1).toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            title: Text(
                              state.list[i].status_transaction,
                              style: TextStyle(color: Colors.black87),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black87,
                            ),
                            initiallyExpanded: false,
                            children: <Widget>[
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.list[i].cart.items.length,
                                itemBuilder: (BuildContext context, int j) {
                                  return Container(
                                    color: Color.fromRGBO(199, 177, 152, 1),
                                    child: ListTile(
                                      title: Text(state.list[i].cart.items[j]
                                          .orderItem.name),
                                      subtitle: Text(state
                                              .list[i].cart.items[j].quantity
                                              .toString() +
                                          ' set'),
                                      trailing: Text(
                                        'Rp. ' +
                                            FlutterMoneyFormatter(
                                                    amount: state
                                                        .list[i]
                                                        .cart
                                                        .items[j]
                                                        .orderItem
                                                        .price
                                                        .toDouble())
                                                .output
                                                .compactNonSymbol,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Divider(
                                height: 8,
                                color: Colors.black87,
                              ),
                              ListTile(
                                trailing: Text(
                                  'Rp. ' +
                                      FlutterMoneyFormatter(
                                              amount: state.list[i].cart.price
                                                  .toDouble())
                                          .output
                                          .nonSymbol,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        else if (state is NotLoadedTransaction){
          return  Center(child: Text('Kamu belum memesan apapun'));
        }
        else{
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(199, 177, 152, 1))));
        }
      },
    );
  }
}
