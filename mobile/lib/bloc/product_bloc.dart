// lib/blocs/product_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import 'package:flutterproject2/models/productmodel.dart';


//Productpage
//Stockpage
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final List<Product> _products = [
    Product(
      name: 'Brown Spanish Latte and Oreo Coffee',
      description: 'Brown Spanish Latte is basically espresso-based coffee with milk. Oreo Iced Coffee Recipe is perfect for a hot summer day.',
      imagePath: 'assets/Productlist/donmacnew.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      name: 'Black Forest',
      description: 'A decadent symphony of flavors featuring luxurious Belgian dark chocolate and succulent Taiwanese strawberries, delicately infused with velvety milk',
      imagePath: 'assets/Productlist/blackforest.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      name: 'Don darko',
      description: 'Crafted from the finest Belgian dark chocolate, harmoniously blended with creamy milk',
      imagePath: 'assets/Productlist/dondarko.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      name: 'Donya Berry',
      description: 'A tantalizing fusion of succulent Taiwanese strawberries mingled with creamy milk',
      imagePath: 'assets/Productlist/donyaberry.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      name: 'Iced Caramel',
      description: 'An exquisite blend of freshly pulled espresso, smooth milk, and luscious caramel syrup, served over a bed of ice',
      imagePath: 'assets/Productlist/icedcaramel.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
      name: 'Macha Berry',
      description: 'A captivating harmony of Japanese matcha and Taiwanese strawberries, artfully intertwined with creamy milk',
      imagePath: 'assets/Productlist/matchaberry.jpg',
      stock: 1000,
      price: 39,
    ),
    Product(
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
        // Simulate a delay (e.g., fetching from a database)
        await Future.delayed(const Duration(seconds: 1));
        emit(ProductLoadSuccess(List.from(_products)));
      } catch (e) {
        emit(ProductOperationFailure(e.toString()));
      }
    });

    on<AddProduct>((event, emit) {
      try {
        _products.add(event.product);
        emit(ProductLoadSuccess(List.from(_products)));
      } catch (e) {
        emit(ProductOperationFailure(e.toString()));
      }
    });

    on<EditProduct>((event, emit) {
      try {
        final index = _products.indexWhere((p) => p.name == event.updatedProduct.name);
        if (index != -1) {
          _products[index] = event.updatedProduct;
          emit(ProductLoadSuccess(List.from(_products)));
        } else {
          emit(const ProductOperationFailure("Product not found"));
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

  // settings_bloc.dart
  
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial());

  @override
  // ignore: override_on_non_overriding_member
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is UpdateProfilePicture) {
      yield SettingsLoading();
      try {
        // Simulate uploading the profile picture
        await Future.delayed(const Duration(seconds: 2));
        yield SettingsSuccess("Profile picture updated successfully!");
      } catch (e) {
        yield SettingsFailure("Failed to update profile picture.");
      }
    } else if (event is UpdatePassword) {
      yield SettingsLoading();
      try {
        if (event.newPassword.isEmpty) {
          throw Exception("Password cannot be empty");
        }
        // Simulate updating the password
        await Future.delayed(const Duration(seconds: 2));
        yield SettingsSuccess("Password updated successfully!");
      } catch (e) {
        yield SettingsFailure(e.toString());
      }
    }
  }
}
