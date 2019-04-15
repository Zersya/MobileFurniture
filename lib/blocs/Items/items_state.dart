import 'package:equatable/equatable.dart';
import 'package:furniture_app/models/item.dart';

abstract class ItemsState extends Equatable {}

class ItemsInitial extends ItemsState {
  @override
  String toString() {
    return 'ItemsInitial';
  }
}

class ItemsLoading extends ItemsState {
  @override
  String toString() {
    return 'ItemsLoading';
  }
}

class ItemsLoaded extends ItemsState {
  final List<Item> items;

  ItemsLoaded(this.items);

  @override
  String toString() {
    return 'LoadedItems';
  }
}

class ItemsNotLoaded extends ItemsState {
  @override
  String toString() {
    return 'ItemsNotLoaded';
  }
}

class InitialDetailItem extends ItemsState {
  @override
  toString() {
    return 'InitialDetailItem';
  }
}

class LoadingDetailItem extends ItemsState {
  @override
  toString() {
    return 'LoadingDetailItem';
  }
}

class LoadedDetailItem extends ItemsState {
  final Item item;

  LoadedDetailItem(this.item);

  @override
  toString() {
    return 'LoadedDetailItem';
  }
}

class SuccessAddItemToCart extends ItemsState {
  final String message;

  SuccessAddItemToCart(this.message);

  @override
  String toString() {
    return 'SuccessAddItemToCart';
  }
}
