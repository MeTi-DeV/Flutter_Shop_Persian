import 'package:flutter/material.dart';
import '../providers/cart.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final DateTime time;
  final double amount;
  final List<CartItem> products;
  OrderItem(
      {required this.id,
      required this.time,
      required this.amount,
      required this.products});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addToOrders(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            time: DateTime.now(),
            amount: total,
            products: cartProducts));
     notifyListeners();
  }
}
