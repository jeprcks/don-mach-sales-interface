// lib/blocs/product_event.dart
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutterproject2/models/productmodel.dart';


abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class EditProduct extends ProductEvent {
  final Product updatedProduct;

  const EditProduct(this.updatedProduct);

  @override
  List<Object?> get props => [updatedProduct];
}

class DeleteProduct extends ProductEvent {
  final Product product;

  const DeleteProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class IncrementStock extends ProductEvent {
  final Product product;

  const IncrementStock(this.product);

  @override
  List<Object?> get props => [product];
}

class DecrementStock extends ProductEvent {
  final Product product;

  const DecrementStock(this.product);

  @override
  List<Object?> get props => [product];
}


// settings_event.dart

abstract class SettingsEvent {}

class UpdateProfilePicture extends SettingsEvent {
  final File profilePicture;

  UpdateProfilePicture(this.profilePicture);
}

class UpdatePassword extends SettingsEvent {
  final String newPassword;

  UpdatePassword(this.newPassword);
}
