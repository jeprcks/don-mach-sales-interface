abstract class SalesEvent {}

class LoadProducts extends SalesEvent {}

class AddToCart extends SalesEvent {
  final Map<String, dynamic> product;
  AddToCart(this.product);
}

class UpdateCartQuantity extends SalesEvent {
  final String productId;
  final int newQuantity;
  UpdateCartQuantity(this.productId, this.newQuantity);
}

class CheckoutCart extends SalesEvent {}
