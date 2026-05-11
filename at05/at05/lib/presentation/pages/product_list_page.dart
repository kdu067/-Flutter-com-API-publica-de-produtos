import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../widgets/product_tile.dart';

class ProductListPage extends StatelessWidget {
  final ProductRepository repository;

  const ProductListPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos FakeStore')),
      body: FutureBuilder<List<Product>>(
        future: repository.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Não foi possível carregar os produtos.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          final products = snapshot.data;
          if (products == null || products.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum produto disponível.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductTile(product: products[index]);
            },
          );
        },
      ),
    );
  }
}
