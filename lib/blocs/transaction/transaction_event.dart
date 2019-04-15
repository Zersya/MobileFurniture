import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {}


class LoadTransaction extends TransactionEvent {
  final String token;

  LoadTransaction(this.token);
  @override
  String toString() {
    return 'LoadTransaction';
  }
}