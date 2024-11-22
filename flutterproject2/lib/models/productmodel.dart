// lib/models/product.dart
class Product {
  String name;
  String description;
  String imagePath;
  int stock;

  Product({
    required this.name,
    required this.description,
    required this.imagePath,
    this.stock = 1000,
  });
}
