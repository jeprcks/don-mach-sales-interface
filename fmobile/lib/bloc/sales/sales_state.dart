abstract class SalesState {}

class SalesInitial extends SalesState {}

class SalesLoading extends SalesState {}

class SalesLoaded extends SalesState {
  final List<dynamic> products;
  final List<Map<String, dynamic>> cart;
  final double subtotal;

  SalesLoaded({
    required this.products,
    required this.cart,
    required this.subtotal,
  });
}

class SalesError extends SalesState {
  final String message;
  SalesError(this.message);
}

class CheckoutSuccess extends SalesState {
  final List<Map<String, dynamic>> orderList;
  final double totalAmount;
  final DateTime transactionDate;

  CheckoutSuccess({
    required this.orderList,
    required this.totalAmount,
    required this.transactionDate,
  });
}
