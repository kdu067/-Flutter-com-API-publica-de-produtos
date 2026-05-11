import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/bloc/products_bloc.dart';
import '../../state/bloc/products_event.dart';
import '../../state/bloc/products_state.dart';

class ProductsBlocPage extends StatefulWidget {
  const ProductsBlocPage({super.key});

  @override
  State<ProductsBlocPage> createState() => _ProductsBlocPageState();
}

class _ProductsBlocPageState extends State<ProductsBlocPage> {
  late ProductsBloc _productsBloc;

  @override
  void initState() {
    super.initState();
    _productsBloc = ProductsBloc();
    _productsBloc.add(const LoadProductsEvent());
  }

  @override
  void dispose() {
    _productsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos - BLoC'),
        elevation: 0,
      ),
      body: BlocBuilder<ProductsBloc, ProductState>(
        bloc: _productsBloc,
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoadedState) {
            final favoriteCount =
                state.products.where((p) => p.favorite).length;
            return Column(
              children: [
                Container(
                  color: Colors.green.shade100,
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
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
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
                              color:
                                  product.favorite ? Colors.red : Colors.grey,
                              size: 28,
                            ),
                            onPressed: () {
                              _productsBloc.add(
                                ToggleFavoriteEvent(product.id),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is ProductErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('Nenhum estado definido'));
        },
      ),
    );
  }
}
