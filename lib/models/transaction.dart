import './item.dart';

class Transaction {
  final String id;
  final String created_at;
  final OrderCart cart;
  final User created_by;
  final String status_transaction;

  Transaction(this.id, this.created_at, this.status_transaction,
      this.created_by, this.cart);

  factory Transaction.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return Transaction(
        parsedJson['_id'],
        parsedJson['created_at'],
        parsedJson['status_transaction'],
        User.fromJson(parsedJson['created_by']),
        OrderCart.fromJson(parsedJson['cart']));
  }
}

class OrderCart {
  final int price;
  final String id;
  final List<OrderCartItems> items;

  OrderCart(this.price, this.id, this.items);

  factory OrderCart.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<OrderCartItems> items = list.map((i) => OrderCartItems.fromJson(i)).toList();
    return OrderCart(parsedJson['price'], parsedJson['_id'], items);
  }
}

class OrderCartItems{
  final OrderItem orderItem;
  final int quantity;

  OrderCartItems(this.orderItem, this.quantity);

  factory OrderCartItems.fromJson(Map<String, dynamic> parsedJson){
    return OrderCartItems(OrderItem.fromJson(parsedJson['itemId']), parsedJson['quantity']);
  }
}

class OrderItem {
  final String id;
  final String name;
  final int price;
  final String category;
  final int quantity;
  final String created_date;
  final List<Image> images;

  OrderItem(this.id, this.name, this.price, this.category, this.quantity, this.created_date, this.images);

  factory OrderItem.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['images'] as List;
    List<Image> listImages = list.map((i) => Image.fromJson(i)).toList();
    return OrderItem(
        parsedJson['_id'],
        parsedJson['name'],
        parsedJson['price'],
        parsedJson['category'],
        parsedJson['quantity'],
        parsedJson['created_date'],
        listImages);
  }
}
