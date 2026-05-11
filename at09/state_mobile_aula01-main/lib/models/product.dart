class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String image;
  bool favorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.description = '',
    this.image = '',
    this.favorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'price': price,
      'description': description,
      'image': image,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? image,
    bool? favorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      favorite: favorite ?? this.favorite,
    );
  }

  @override
  String toString() =>
      'Product(id: $id, name: $name, price: $price, description: $description)';
}
