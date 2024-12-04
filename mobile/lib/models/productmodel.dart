// lib/models/product.dart
class Product {
  String productId;
  String name;
  String description;
  String imagePath;
  int stock;
  double price;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.stock,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      name: json['product_name'],
      description: json['description'],
      imagePath: json['product_image'],
      stock: json['product_stock'],
      price: double.parse(json['product_price'].toString()),
    );
  }
}