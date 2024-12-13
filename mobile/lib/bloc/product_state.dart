// lib/blocs/product_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutterproject2/models/productmodel.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoadInProgress extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final List<Product> products;

  const ProductLoadSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductOperationFailure extends ProductState {
  final String error;

  const ProductOperationFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class SalesPageState extends ProductState {}

// settings_state.dart
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {
  final String message;

  SettingsSuccess(this.message);
}

class SettingsFailure extends SettingsState {
  final String error;

  SettingsFailure(this.error);
}
