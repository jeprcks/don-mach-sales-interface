import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/sales_repository.dart';
import 'sales_event.dart';
import 'sales_state.dart';
import 'dart:convert';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final SalesRepository repository;

  SalesBloc({required this.repository}) : super(SalesInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddToCart>(_onAddToCart);
    on<UpdateCartQuantity>(_onUpdateCartQuantity);
    on<CheckoutCart>(_onCheckoutCart);
  }

  final List<Map<String, dynamic>> _cart = [];

  void _onLoadProducts(LoadProducts event, Emitter<SalesState> emit) async {
    emit(SalesLoading());
    try {
      final products = await repository.fetchProducts();
      emit(SalesLoaded(
        products: products,
        cart: _cart,
        subtotal: _calculateSubtotal(),
      ));
    } catch (e) {
      emit(SalesError(e.toString()));
    }
  }

  void _onAddToCart(AddToCart event, Emitter<SalesState> emit) async {
    if (state is SalesLoaded) {
      final currentState = state as SalesLoaded;
      final existingItem = _cart.firstWhere(
        (item) => item['product_id'] == event.product['product_id'],
        orElse: () => {},
      );

      if (existingItem.isEmpty) {
        _cart.add({
          ...event.product,
          'quantity': 1,
        });
      } else {
        existingItem['quantity']++;
      }

      emit(SalesLoaded(
        products: currentState.products,
        cart: _cart,
        subtotal: _calculateSubtotal(),
      ));
    }
  }

  void _onUpdateCartQuantity(
      UpdateCartQuantity event, Emitter<SalesState> emit) async {
    if (state is SalesLoaded) {
      final currentState = state as SalesLoaded;
      if (event.newQuantity <= 0) {
        _cart.removeWhere((item) => item['product_id'] == event.productId);
      } else {
        final item =
            _cart.firstWhere((item) => item['product_id'] == event.productId);
        item['quantity'] = event.newQuantity;
      }

      emit(SalesLoaded(
        products: currentState.products,
        cart: _cart,
        subtotal: _calculateSubtotal(),
      ));
    }
  }

  void _onCheckoutCart(CheckoutCart event, Emitter<SalesState> emit) async {
    if (state is SalesLoaded) {
      try {
        final orderList = _cart.map((item) => {
          'product_id': item['product_id'],
          'name': item['product_name'],
          'quantity': item['quantity'],
          'price': item['product_price'],
        }).toList();

        print('Sending order: ${jsonEncode({
          'order_list': orderList,
          'total_order': _calculateSubtotal(),
        })}');

        await repository.createSale(orderList, _calculateSubtotal());
        
        // Emit success state with order details
        emit(CheckoutSuccess(
          orderList: orderList,
          totalAmount: _calculateSubtotal(),
          transactionDate: DateTime.now(),
        ));
        
        // Clear cart and reload products after successful emission
        _cart.clear();
        add(LoadProducts());
      } catch (e) {
        print('Checkout error: $e');
        emit(SalesError(e.toString()));
      }
    }
  }

  double _calculateSubtotal() {
    return _cart.fold(
      0,
      (sum, item) => sum + (item['product_price'] * item['quantity']),
    );
  }
}
