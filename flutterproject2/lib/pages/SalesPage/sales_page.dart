import 'package:flutter/material.dart';
import 'package:flutterproject2/models/transactionmode.dart';
import 'package:flutterproject2/bloc/product_bloc.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {

  // Increment product quantity
  void _incrementQuantity(int index) {
    setState(() {
      products[index]['quantity']++;
      total += products[index]['price'];
    });
  }

  // Decrement product quantity
  void _decrementQuantity(int index) {
    if (products[index]['quantity'] > 0) {
      setState(() {
        products[index]['quantity']--;
        total -= products[index]['price'];
      });
    }
  }

  // Checkout process
  void _checkout() {
  // Get the list of ordered products
  List<Map<String, dynamic>> orderedProducts =
      products.where((product) => product['quantity'] > 0).map((product) {
        
        return {
          'name': product['name'],
          'price': product['price'],
          'quantity': product['quantity'],
        };
      }).toList();

  if (orderedProducts.isNotEmpty) {
    // Create a new transaction with the current date
    final newTransaction = Transaction(
      orderNumber: currentOrderNumber++,
      orderList: orderedProducts,
      totalPrice: total,
      date: DateTime.now(), // Add transaction date
    );

    // Add transaction to the history
    transactionHistory.add(newTransaction);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('TRANSACTION SUCCESSFUL'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order Number: ${newTransaction.orderNumber}'),
                const SizedBox(height: 10),
                Text('Date: ${newTransaction.date.toLocal()}'), // Display the date
                const SizedBox(height: 10),
                const Text('Order List:'),
                ...orderedProducts.map((product) {
                  return Text(
                      '${product['name']} - ${product['quantity']} x ₱${product['price']}');
                }),
                const SizedBox(height: 10),
                Text('Total: ₱${total.toStringAsFixed(2)}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetOrder();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


  // Reset the order after checkout
  void _resetOrder() {
    setState(() {
      for (var product in products) {
        product['quantity'] = 0;
      }
      total = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Interface'),
        backgroundColor: Colors.brown,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Products',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('₱${product['price']}'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => _decrementQuantity(index),
                                icon: const Icon(Icons.remove),
                              ),
                              Text('${product['quantity']}'),
                              IconButton(
                                onPressed: () => _incrementQuantity(index),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ₱${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _checkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                    ),
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
