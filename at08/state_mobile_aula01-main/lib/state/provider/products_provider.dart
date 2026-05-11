import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/product.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  int get favoriteCount => _products.where((p) => p.favorite).length;

  List<Product> get favoriteProducts =>
      _products.where((p) => p.favorite).toList();

  ProductsProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _products = data.map((json) => Product.fromJson(json)).toList();
      } else {
        _errorMessage = 'Erro ao carregar produtos';
      }
    } catch (e) {
      _errorMessage = 'Erro de conexão: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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

