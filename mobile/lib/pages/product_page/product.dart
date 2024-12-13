import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterproject2/models/productmodel.dart';
import '../../bloc/product_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ProductBloc(),
        child: const ProductPage(),
      ),
    );
  }
}

final List<Product> products = [
  Product(
    name: 'Brown Spanish Latte and Oreo Coffee',
    description:
        'Brown Spanish Latte is basically espresso-based coffee with milk. Oreo Iced Coffee Recipe is perfect for a hot summer day.',
    imagePath: 'assets/Productlist/donmacnew.jpg',
    stock: 10,
    price: 39,
  ),
  Product(
    name: 'Black Forest',
    description:
        'A decadent symphony of flavors featuring luxurious Belgian dark chocolate and succulent Taiwanese strawberries, delicately infused with velvety milk',
    imagePath: 'assets/Productlist/blackforest.jpg',
    stock: 5,
    price: 39,
  ),
  Product(
    name: 'Don Darko',
    description:
        'Crafted from the finest Belgian dark chocolate, harmoniously blended with creamy milk',
    imagePath: 'assets/Productlist/dondarko.jpg',
    stock: 8,
    price: 39,
  ),
];

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown,
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image.asset(
                  product.imagePath,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '₱${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Stock: ${product.stock}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
