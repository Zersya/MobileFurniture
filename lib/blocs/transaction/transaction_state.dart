import 'package:equatable/equatable.dart';
import 'package:furniture_app/models/transaction.dart';

abstract class TransactionState extends Equatable {}

class InitialTransaction extends TransactionState {
  @override
  String toString() {
    return 'InitialTransaction';
  }
}

class LoadingTransaction extends TransactionState {
  @override
  String toString() {
    return 'LoadingTransaction';
  }
}

class LoadedTransaction extends TransactionState {
  final List<Transaction> list;

  LoadedTransaction(this.list);
  @override
  String toString() {
    return 'LoadedTransaction';
  }
}

class NotLoadedTransaction extends TransactionState {
  final String message;

  NotLoadedTransaction(this.message);
  @override
  String toString() {
    return 'NotLoadedTransaction';
  }
}
