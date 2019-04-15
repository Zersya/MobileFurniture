import 'package:equatable/equatable.dart';
import 'package:furniture_app/models/item.dart';

abstract class ItemsEvent extends Equatable {}

class LoadItems extends ItemsEvent {
  final token;

  LoadItems(this.token);
  @override
  String toString() {
    return 'LoadItems';
  }
}

class SelectDetailItem extends ItemsEvent {
  final Item item;

  SelectDetailItem(this.item);

  @override
  toString() {
    return 'LoadingDetailItem';
  }
}

