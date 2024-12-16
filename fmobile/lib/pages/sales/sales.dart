import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sales/sales_bloc.dart';
import '../../bloc/sales/sales_event.dart';
import '../../bloc/sales/sales_state.dart';
import '../../repositories/sales_repository.dart';
import '../../widgets/transaction_receipt_modal.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SalesBloc(repository: SalesRepository())..add(LoadProducts()),
      child: const SalesView(),
    );
  }
}

class SalesView extends StatelessWidget {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesBloc, SalesState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          showDialog(
            context: context,
            builder: (context) => TransactionReceiptModal(
              orderList: state.orderList,
              totalAmount: state.totalAmount,
              transactionDate: state.transactionDate,
            ),
          );
        } else if (state is SalesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Dismiss',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SalesLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SalesError) {
          return Scaffold(
            body: Center(child: Text('Error: ${state.message}')),
          );
        }

        if (state is SalesLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sales Interface',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xFF795548),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/homepage'),
              ),
            ),
            body: Container(
              color: const Color(0xFFFFF8E7),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFF8E7),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      'http://localhost:8000/images/${product['product_image']}',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        product['product_name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4B3025),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '₱${product['product_price'].toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6B4226),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => context
                                            .read<SalesBloc>()
                                            .add(AddToCart(product)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF6B4226),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text('Add to Cart'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  if (state.cart.isNotEmpty)
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Your Cart',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4B3025),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.cart.length,
                              itemBuilder: (context, index) {
                                final item = state.cart[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    title: Text(
                                      item['product_name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4B3025),
                                      ),
                                    ),
                                    subtitle: Text(
                                      '₱${item['product_price'].toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Color(0xFF6B4226),
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                              Icons.remove_circle_outline),
                                          color: const Color(0xFF6B4226),
                                          onPressed: () => context
                                              .read<SalesBloc>()
                                              .add(UpdateCartQuantity(
                                                  item['product_id'],
                                                  item['quantity'] - 1)),
                                        ),
                                        Text(
                                          '${item['quantity']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.add_circle_outline),
                                          color: const Color(0xFF6B4226),
                                          onPressed: () => context
                                              .read<SalesBloc>()
                                              .add(UpdateCartQuantity(
                                                  item['product_id'],
                                                  item['quantity'] + 1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal: ₱${state.subtotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B3025),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<SalesBloc>()
                                    .add(CheckoutCart()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF10B981),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Proceed to Checkout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text('Something went wrong')),
        );
      },
    );
  }
}
