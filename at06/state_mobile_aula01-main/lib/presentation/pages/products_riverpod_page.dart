import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/riverpod/products_riverpod.dart';

class ProductsRiverpodPage extends ConsumerWidget {
  const ProductsRiverpodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final favoriteCount = ref.watch(favoriteCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos - Riverpod'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.purple.shade100,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total de favoritos: $favoriteCount',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Mostrar apenas favoritos
                  },
                  child: const Text('Ver Favoritos'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'R\$ ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        product.favorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.favorite ? Colors.red : Colors.grey,
                        size: 28,
                      ),
                      onPressed: () {
                        ref
                            .read(productsProvider.notifier)
                            .toggleFavorite(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
