// lib/models/product.dart
class Product {
  String name;
  String description;
  String imagePath;
  int stock;
  double price;

  Product({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.stock,
    required this.price,
  });
}