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
    required this.description,
    required this.image,
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
}
