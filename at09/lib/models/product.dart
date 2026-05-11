class Product {
  final String? id;
  final String name;
  final double price;
  final String description;
  final String? imageUrl;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    this.imageUrl,
  });

  /// Converte um JSON da API para um objeto Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String?,
      name: json['name'] as String? ?? 'Sem nome',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
    );
  }

  /// Converte um objeto Product para JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'price': price,
      'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  /// Cria uma cópia do Product com campos opcionalmente atualizados
  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$price)';
}
