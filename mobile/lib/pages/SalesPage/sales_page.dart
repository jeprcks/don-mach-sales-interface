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
                  Text(
                      'Date: ${newTransaction.date.toLocal()}'), // Display the date
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
                '/homepage'); // or Navigator.pop(context);
          },
        ),
        title: const Text('Sales Interface'),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Products Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            product['imageUrl'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '₱${product['price']}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              ElevatedButton(
                                onPressed: () => _incrementQuantity(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  minimumSize: const Size.fromHeight(36),
                                ),
                                child: const Text('Add to Cart'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Cart Section
            const SizedBox(height: 20),
            const Text(
              'Your Cart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Product',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Price',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Quantity',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Action',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                // Add cart items here
                ...products
                    .where((product) => product['quantity'] > 0)
                    .map((product) => TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product['name']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('₱${product['price']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${product['quantity']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  int index = products.indexOf(product);
                                  _decrementQuantity(index);
                                },
                              ),
                            ),
                          ],
                        )),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal: ₱${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: _checkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Proceed to Checkout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
