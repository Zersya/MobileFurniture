import 'package:bloc/bloc.dart';
import 'package:furniture_app/blocs/transaction/transaction_event.dart';
import 'package:furniture_app/blocs/transaction/transaction_state.dart';
import 'package:furniture_app/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final url = 'https://harpah-app.herokuapp.com/';

  @override
  TransactionState get initialState => InitialTransaction();

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is LoadTransaction) {
      yield* _loadTransaction(url+'api/customer/transaction', event.token);
    }
  }

  Stream<TransactionState> _loadTransaction(url, token) async*{
    var res = await http.get(url, headers: {
      'Authorization': token,
    });

    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      List<Transaction> transactions = data.map((f) => Transaction.fromJson(f)).toList();
      yield LoadedTransaction(transactions);
      return;
    }

    yield NotLoadedTransaction('Tidak ada transaksi sebelumnya');
  }

}
