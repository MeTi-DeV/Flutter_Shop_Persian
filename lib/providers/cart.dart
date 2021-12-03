import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  final double price;
  final int quantity;
  final String title;
  CartItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addToCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1,
              title: existingCartItem.title));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            price: price,
            quantity: 1,
            title: title),
      );
    }
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }
  // int get itemsCount {
  //   notifyListeners();
  //   return _items.length;
  // }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void SingleRemoveItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingItem) => CartItem(
              id: existingItem.id,
              price: existingItem.price,
              quantity: existingItem.quantity - 1,
              title: existingItem.title));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
    ;
  }

  void cartRemoveToggle(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
