class Product {
  final int id;
  final String title;
  final String description;
  final String image;
  final List<String> ingredients;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.ingredients,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      price: (json['price'] ?? (5 + json['id'] % 10)).toDouble(),
    );
  }
}
