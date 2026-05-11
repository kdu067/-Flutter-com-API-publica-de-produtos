import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductState> {
  final List<Product> _products = [
    Product(id: '1', name: 'Notebook', price: 3500),
    Product(id: '2', name: 'Mouse', price: 120),
    Product(id: '3', name: 'Teclado', price: 250),
    Product(id: '4', name: 'Monitor', price: 900),
    Product(id: '5', name: 'Webcam', price: 180),
    Product(id: '6', name: 'Headset', price: 450),
  ];

  ProductsBloc() : super(const ProductInitialState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<MarkAsFavoriteEvent>(_onMarkAsFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoadingState());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ProductLoadedState(_products));
    } catch (e) {
      emit(ProductErrorState('Erro ao carregar produtos: $e'));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final product = _products.firstWhere((p) => p.id == event.productId);
      product.favorite = !product.favorite;
      emit(ProductLoadedState(List.from(_products)));
    } catch (e) {
      emit(ProductErrorState('Erro ao alternar favorito: $e'));
    }
  }

  Future<void> _onMarkAsFavorite(
    MarkAsFavoriteEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final product = _products.firstWhere((p) => p.id == event.productId);
      product.favorite = true;
      emit(ProductLoadedState(List.from(_products)));
    } catch (e) {
      emit(ProductErrorState('Erro ao marcar como favorito: $e'));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final product = _products.firstWhere((p) => p.id == event.productId);
      product.favorite = false;
      emit(ProductLoadedState(List.from(_products)));
    } catch (e) {
      emit(ProductErrorState('Erro ao remover favorito: $e'));
    }
  }
}
