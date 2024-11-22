import 'package:flutter/material.dart';
import 'package:flutterproject2/models/transactionmode.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown,
      body: transactionHistory.isNotEmpty
          ? ListView.builder(
              itemCount: transactionHistory.length,
              itemBuilder: (context, index) {
                final transaction = transactionHistory[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Number: ${transaction.orderNumber}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Date: ${transaction.date.toLocal()}',
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        const SizedBox(height: 8),
                        const Text('Order List:'),
                        ...transaction.orderList.map((product) {
                          return Text(
                              '${product['name']} - ${product['quantity']} x ₱${product['price']}');
                        }),
                        const SizedBox(height: 8),
                        Text(
                          'Total Price: ₱${transaction.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                'No transactions available.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
    );
  }
}
