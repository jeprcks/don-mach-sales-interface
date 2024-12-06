// lib/blocs/product_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_event.dart';
import 'product_state.dart';
import 'package:flutterproject2/models/productmodel.dart';

//Productpage
//Stockpage
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final List<Product> _products = [
    Product(
      productId: '1',
      name: 'Brown Spanish Latte',
      description: 'Brown Spanish Latte is basically espresso-based coffee with milk.',
      imagePath: 'assets/Productlist/brownspanishlatte.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      productId: '2',
      name: 'Oreo Coffee',
      description: 'Oreo Iced Coffee Recipe is perfect for a hot summer day.',
      imagePath: 'assets/Productlist/oreo.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      productId: '3',
      name: 'Black Forest',
      description: 'A decadent symphony of flavors featuring luxurious Belgian dark chocolate and succulent Taiwanese strawberries, delicately infused with velvety milk',
      imagePath: 'assets/Productlist/blackforest.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      productId: '4',
      name: 'Don darko',
      description: 'Crafted from the finest Belgian dark chocolate, harmoniously blended with creamy milk',
      imagePath: 'assets/Productlist/dondarko.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      productId: '5',
      name: 'Donya Berry',
      description: 'A tantalizing fusion of succulent Taiwanese strawberries mingled with creamy milk',
      imagePath: 'assets/Productlist/donyaberry.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      productId: '6',
      name: 'Iced Caramel',
      description: 'An exquisite blend of freshly pulled espresso, smooth milk, and luscious caramel syrup, served over a bed of ice',
      imagePath: 'assets/Productlist/icedcaramel.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      productId: '7',
      name: 'Macha Berry',
      description: 'A captivating harmony of Japanese matcha and Taiwanese strawberries, artfully intertwined with creamy milk',
      imagePath: 'assets/Productlist/matchaberry.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      productId: '8',
      name: 'Macha',
      description: 'A macchiato has steamed and frothed milk, and that foam goes on top of the shot of espresso or matcha.',
      imagePath: 'assets/Productlist/macha.jpg',
      stock: 1000,
      price: 39,
    ),
  ];

  ProductBloc() : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoadInProgress());
      try {
        print('Fetching products...');
        final response = await http.get(
          Uri.parse('http://10.0.2.2:8000/api/products'),
        );
        
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final List<dynamic> productList = data['products'];
          final products = productList.map((json) => Product.fromJson(json)).toList();
          print('Products loaded: ${products.length}');
          emit(ProductLoadSuccess(products));
        } else {
          print('Failed to load products: ${response.statusCode}');
          emit(const ProductOperationFailure('Failed to load products'));
        }
      } catch (e) {
        print('Error loading products: $e');
        emit(ProductOperationFailure(e.toString()));
      }
    });

    on<AddProduct>((event, emit) async {
      try {
        // Add API call here for creating product
        emit(ProductLoadSuccess(List.from(_products)));
      } catch (e) {
        emit(ProductOperationFailure(e.toString()));
      }
    });

    on<EditProduct>((event, emit) async {
      try {
        // Add API call here for updating product
        final index = _products.indexWhere((p) => p.productId == event.updatedProduct.productId);
        if (index != -1) {
          _products[index] = event.updatedProduct;
          emit(ProductLoadSuccess(List.from(_products)));
        }
      } catch (e) {
        emit(ProductOperationFailure(e.toString()));
      }
    });

    on<DeleteProduct>((event, emit) {
      try {
        _products.remove(event.product);
        emit(ProductLoadSuccess(List.from(_products)));
      } catch (e) {
        emit(ProductOperationFailure(e.toString()));
      }
    });

    on<IncrementStock>((event, emit) {
      try {
        final index = _products.indexWhere((p) => p.name == event.product.name);
        if (index != -1) {
          _products[index].stock += 1;
          emit(ProductLoadSuccess(List.from(_products)));
        } else {
          emit(const ProductOperationFailure("Product not found"));
        }
      } catch (e) {
        emit(ProductOperationFailure(e.toString()));
      }
    });

    on<DecrementStock>((event, emit) {
      try {
        final index = _products.indexWhere((p) => p.name == event.product.name);
        if (index != -1) {
          if (_products[index].stock > 0) {
            _products[index].stock -= 1;
            emit(ProductLoadSuccess(List.from(_products)));
          } else {
            emit(const ProductOperationFailure("Stock cannot be less than zero"));
          }
        } else {
          emit(const ProductOperationFailure("Product not found"));
        }
      } catch (e) {
        emit(ProductOperationFailure(e.toString()));
      }
    });
  }
}

//sales_page
final List<Map<String, dynamic>> products = [
    {'name': 'Brown Spanish Latte', 'price': 39.00, 'quantity': 0},
    {'name': 'Oreo Coffee', 'price': 39.00, 'quantity': 0},
    {'name': 'Black Forest', 'price': 39.00, 'quantity': 0},
    {'name': 'Don Darko', 'price': 39.00, 'quantity': 0},
    {'name': 'Donya Berry', 'price': 39.00, 'quantity': 0},
    {'name': 'Iced Caramel', 'price': 39.00, 'quantity': 0},
    {'name': 'Macha Berry', 'price': 39.00, 'quantity': 0},
  ];
  double total = 0.0;

