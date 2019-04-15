import 'dart:convert';

class Item {
  final String id;
  final String name;
  final int price;
  final String category;
  final int quantity;
  final String created_date;
  final List<Image> images;
  final User created_by;

  Item(this.id, this.name, this.price, this.category, this.quantity,
      this.created_date, this.images, this.created_by);


  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['images'] as List;
    print(list.runtimeType);
    List<Image> listImages = list.map((i) => Image.fromJson(i)).toList();
    return Item(
        parsedJson['_id'],
        parsedJson['name'],
        parsedJson['price'],
        parsedJson['category'],
        parsedJson['quantity'],
        parsedJson['created_date'],
        listImages,
        User.fromJson(parsedJson['created_by']));
  }

}

class Image {
  final String id;
  final String imagename;
  final String imageurl;

  Image(this.id, this.imagename, this.imageurl);

  factory Image.fromJson(Map<String, dynamic> parsedJson) {
    return Image(
        parsedJson['_id'], parsedJson['nameImage'], parsedJson['urlImage']);
  }
}

class User {
  final String id;
  final String name;
  final String user;

  User(this.id, this.name, this.user);

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(parsedJson['_id'], parsedJson['name'], parsedJson['user']);
  }
}

class ItemCart {
  final Item id;
  final int quantity;
  final int priceOne;
  final int priceAll;

  ItemCart(this.id, this.quantity, this.priceOne, this.priceAll);

  factory ItemCart.fromJson(Map<String, dynamic> parsedJson){
    return ItemCart(Item.fromJson(parsedJson['_id']), parsedJson['quantity'], parsedJson['priceOne'], parsedJson['priceAll']);
  }
}

class Cart {
  final String id;
  final List<ItemCart> itemsCart;
  final int price;
  final User created_by;

  Cart(this.id, this.itemsCart, this.price, this.created_by);


  factory Cart.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['itemCarts'] as List;
    List<ItemCart> itemsCart = list.map((i) => ItemCart.fromJson(i)).toList();

    return Cart(parsedJson['_id'], itemsCart, parsedJson['price'], User.fromJson(parsedJson['created_by']));
  }
}