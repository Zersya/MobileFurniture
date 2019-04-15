import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:furniture_app/models/item.dart';
import 'package:furniture_app/models/response.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final url = 'https://harpah-app.herokuapp.com/';

  @override
  // TODO: implement initialState
  CartState get initialState => InitialCart();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    yield LoadingCart();

    if (event is AddItemToCart) {
      String itemId = event.item.id;
      yield* _addToCart(
          url +
              'api/customer/cart/?itemId=' +
              itemId +
              '&quantity=' +
              event.quantity.toString(),
          event);
    }

    if (event is LoadCart) {
      yield* _loadCart(url + 'api/customer/cart', event);
    }

    if (event is SubmitCart) {
      yield* _submitCart(url + 'api/customer/transaction', event);
    }

    if (event is DeleteCart) {
      yield* _deleteCart(
          url + 'api/customer/cart/?itemId=' + event.cartid, event.token);
    }
  }

  Stream<CartState> _deleteCart(url, token) async* {
    var response = await http.delete(url, headers: {
      'Authorization': token,
    });
    var data = json.decode(response.body);
    var res = Response.fromJson(data);
    if (response.statusCode == 200) {
      yield DeletedCart(res.message);
    }
  }

  Stream<CartState> _addToCart(url, event) async* {
    var response = await http.post(url, headers: {
      'Authorization': event.token,
    });
    var data = json.decode(response.body);
    var res = Response.fromJson(data);
    if (response.statusCode == 200) {
      yield AddedItemToCart(res.message);
    } else {
      print(response.statusCode);
    }
  }

  Stream<CartState> _loadCart(url, event) async* {
    var response = await http.get(url, headers: {
      'Authorization': event.token,
    });
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      var cart = Cart.fromJson(data[0]);
      print(cart);
      yield LoadedCart(cart);
    }
  }

  Stream<CartState> _submitCart(url, event) async* {
    var response = await http.post(url, headers: {
      'Authorization': event.token,
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var res = Response.fromJson(data);
      yield SubmitedToOrder(res.message);
    }
  }
}

abstract class CartEvent extends Equatable {}

class AddItemToCart extends CartEvent {
  final Item item;
  final String token;
  final int quantity;
  AddItemToCart(this.item, this.quantity, this.token);
  @override
  String toString() {
    return 'AddItemToCart';
  }
}

class LoadCart extends CartEvent {
  final String token;

  LoadCart(this.token);

  @override
  String toString() {
    return 'LoadCart';
  }
}

class SubmitCart extends CartEvent {
  final String token;

  SubmitCart(this.token);
  @override
  String toString() {
    return 'SubmitCart';
  }
}

class DeleteCart extends CartEvent {
  final String token, cartid;

  DeleteCart(this.token, this.cartid);
  @override
  String toString() {
    return 'DeleteCart';
  }
}

abstract class CartState extends Equatable {}

class InitialCart extends CartState {
  @override
  String toString() {
    return 'InitialCart';
  }
}

class LoadingCart extends CartState {
  @override
  String toString() {
    return 'LoadingCart';
  }
}

class LoadedCart extends CartState {
  final Cart cart;

  LoadedCart(this.cart);
  @override
  String toString() {
    return 'LoadedCart';
  }
}

class AddedItemToCart extends CartState {
  final String message;

  AddedItemToCart(this.message);
  @override
  String toString() {
    return 'AddedItemToCart';
  }
}

class SubmitedToOrder extends CartState {
  final String message;

  SubmitedToOrder(this.message);

  @override
  String toString() {
    return 'SubmitedToOrder';
  }
}

class DeletedCart extends CartState {
  final String message;

  DeletedCart(this.message);

  @override
  String toString() {
    return 'DeletedCart';
  }
}
