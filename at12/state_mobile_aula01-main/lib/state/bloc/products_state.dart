import '../../models/product.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitialState extends ProductState {
  const ProductInitialState();
}

class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  const ProductLoadedState(this.products);
}

class ProductErrorState extends ProductState {
  final String message;

  const ProductErrorState(this.message);
}
