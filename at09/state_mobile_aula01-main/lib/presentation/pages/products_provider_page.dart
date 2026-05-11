import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/provider/products_provider.dart';
import 'product_details_page.dart';

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
          if (productsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productsProvider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                productsProvider.errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(product: product),
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.all(12),
                        leading: product.image.isNotEmpty
                            ? Image.network(
                                product.image,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              )
                            : null,
                        title: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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

