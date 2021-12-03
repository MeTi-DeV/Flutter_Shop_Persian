import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  bool isFavorite;
  Product(
      {required this.id,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.price,
      this.isFavorite = false});
  void isFavoriteToggle() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
