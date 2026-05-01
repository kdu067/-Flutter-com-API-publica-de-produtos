import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductsProvider extends ChangeNotifier {
  final List<Product> _products = [
    Product(id: '1', name: 'Notebook', price: 3500),
    Product(id: '2', name: 'Mouse', price: 120),
    Product(id: '3', name: 'Teclado', price: 250),
    Product(id: '4', name: 'Monitor', price: 900),
    Product(id: '5', name: 'Webcam', price: 180),
    Product(id: '6', name: 'Headset', price: 450),
  ];

  List<Product> get products => _products;

  int get favoriteCount => _products.where((p) => p.favorite).length;

  List<Product> get favoriteProducts =>
      _products.where((p) => p.favorite).toList();

  void toggleFavorite(String productId) {
    final product = _products.firstWhere((p) => p.id == productId);
    product.favorite = !product.favorite;
    notifyListeners();
  }

  void markAsFavorite(String productId) {
    final product = _products.firstWhere((p) => p.id == productId);
    product.favorite = true;
    notifyListeners();
  }

  void removeFavorite(String productId) {
    final product = _products.firstWhere((p) => p.id == productId);
    product.favorite = false;
    notifyListeners();
  }
}
