import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/product.dart';

class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier()
      : super([
          Product(id: '1', name: 'Notebook', price: 3500),
          Product(id: '2', name: 'Mouse', price: 120),
          Product(id: '3', name: 'Teclado', price: 250),
          Product(id: '4', name: 'Monitor', price: 900),
          Product(id: '5', name: 'Webcam', price: 180),
          Product(id: '6', name: 'Headset', price: 450),
        ]);

  void toggleFavorite(String productId) {
    state = [
      for (final product in state)
        if (product.id == productId)
          Product(
            id: product.id,
            name: product.name,
            price: product.price,
            favorite: !product.favorite,
          )
        else
          product,
    ];
  }

  void markAsFavorite(String productId) {
    state = [
      for (final product in state)
        if (product.id == productId)
          Product(
            id: product.id,
            name: product.name,
            price: product.price,
            favorite: true,
          )
        else
          product,
    ];
  }

  void removeFavorite(String productId) {
    state = [
      for (final product in state)
        if (product.id == productId)
          Product(
            id: product.id,
            name: product.name,
            price: product.price,
            favorite: false,
          )
        else
          product,
    ];
  }

  int get favoriteCount => state.where((p) => p.favorite).length;

  List<Product> get favoriteProducts => state.where((p) => p.favorite).toList();
}

final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<Product>>((ref) {
  return ProductsNotifier();
});

final favoriteCountProvider = Provider<int>((ref) {
  final products = ref.watch(productsProvider);
  return products.where((p) => p.favorite).length;
});

final favoriteProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productsProvider);
  return products.where((p) => p.favorite).toList();
});
