import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/provider/products_provider.dart';

class ProductsProviderPage extends StatelessWidget {
  const ProductsProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos - Provider'),
        elevation: 0,
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, productsProvider, _) {
          return Column(
            children: [
              Container(
                color: Colors.blue.shade100,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total de favoritos: ${productsProvider.favoriteCount}',
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
                  itemCount: productsProvider.products.length,
                  itemBuilder: (context, index) {
                    final product = productsProvider.products[index];
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
                            productsProvider.toggleFavorite(product.id);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
