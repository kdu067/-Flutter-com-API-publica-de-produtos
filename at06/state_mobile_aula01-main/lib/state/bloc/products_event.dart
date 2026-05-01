abstract class ProductEvent {
  const ProductEvent();
}

class LoadProductsEvent extends ProductEvent {
  const LoadProductsEvent();
}

class ToggleFavoriteEvent extends ProductEvent {
  final String productId;

  const ToggleFavoriteEvent(this.productId);
}

class MarkAsFavoriteEvent extends ProductEvent {
  final String productId;

  const MarkAsFavoriteEvent(this.productId);
}

class RemoveFavoriteEvent extends ProductEvent {
  final String productId;

  const RemoveFavoriteEvent(this.productId);
}
