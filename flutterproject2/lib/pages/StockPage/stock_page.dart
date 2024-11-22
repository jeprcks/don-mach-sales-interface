import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterproject2/models/productmodel.dart';
import 'package:flutterproject2/bloc/product_bloc.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ProductBloc(), // Providing ProductBloc
        child: const StockPage(), // StockPage can now access ProductBloc
      ),
    );
  }
}

final List<Product> products = [
  Product(
    name: 'Brown Spanish Latte and Oreo Coffee',
    description: 'Brown Spanish Latte is basically espresso-based coffee with milk. Oreo Iced Coffee Recipe is perfect for a hot summer day.',
    imagePath: 'assets/Productlist/donmacnew.jpg',
    stock: 1000,
  ),
  Product(
    name: 'Black Forest',
    description: 'A decadent symphony of flavors featuring luxurious Belgian dark chocolate and succulent Taiwanese strawberries, delicately infused with velvety milk',
    imagePath: 'assets/Productlist/blackforest.jpg',
    stock: 1000,
  ),
  Product(
    name: 'Don darko',
    description: 'Crafted from the finest Belgian dark chocolate, harmoniously blended with creamy milk',
    imagePath: 'assets/Productlist/dondarko.jpg',
    stock: 1000,
  ),
  Product(
    name: 'Donya Berry',
    description: 'A tantalizing fusion of succulent Taiwanese strawberries mingled with creamy milk',
    imagePath: 'assets/Productlist/donyaberry.jpg',
    stock: 1000,
  ),
  Product(
    name: 'Iced Caramel',
    description: 'An exquisite blend of freshly pulled espresso, smooth milk, and luscious caramel syrup, served over a bed of ice',
    imagePath: 'assets/Productlist/icedcaramel.jpg',
    stock: 1000,
  ),
  Product(
    name: 'Macha Berry',
    description: 'A captivating harmony of Japanese matcha and Taiwanese strawberries, artfully intertwined with creamy milk',
    imagePath: 'assets/Productlist/matchaberry.jpg',
    stock: 1000,
  ),
  Product(
    name: 'Macha',
    description: 'A macchiato has steamed and frothed milk, and that foam goes on top of the shot of espresso or matcha.',
    imagePath: 'assets/Productlist/macha.jpg',
    stock: 1000,
  ),
];

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stocks'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Image section
                Image.asset(
                  product.imagePath,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                // Text section
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Stock: ${product.stock}', // Display stock level
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Edit button
                ElevatedButton(
                  onPressed: () {
                    _showEditProductForm(context, product);
                  },
                  child: const Text('Edit Product'),
                ),
                // Delete button
                ElevatedButton(
                  onPressed: () {
                    _deleteProduct(context, product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductForm(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add), 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _addProduct(String name, String description, String imagePath, int stock) {
    final nameExists = products.any((product) => product.name == name);
    final imageExists = products.any((product) => product.imagePath == imagePath);

    if (nameExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed: Product name already exists!')),
      );
      return;
    }

    if (imageExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image path already in use!')),
      );
      return;
    }

    setState(() {
      products.add(
        Product(name: name, description: description, imagePath: imagePath),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product added successfully!')),
    );
  }

  void _showAddProductForm(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final imagePathController = TextEditingController();
    final stockController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Product',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: imagePathController,
                  decoration: const InputDecoration(
                    labelText: 'Image Path',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: stockController,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(),
                  ),
                   keyboardType: TextInputType.number,
                  ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final description = descriptionController.text;
                    final imagePath = imagePathController.text;
                    final stock = int.tryParse(stockController.text) ?? 1000; 

                    if (name.isNotEmpty && description.isNotEmpty && imagePath.isNotEmpty) {
                      _addProduct(name, description, imagePath,stock);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('All fields are required!')),
                      );
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditProductForm(BuildContext context, Product product) {
    final nameController = TextEditingController(text: product.name);
    final descriptionController = TextEditingController(text: product.description);
    final imagePathController = TextEditingController(text: product.imagePath);
    final stockController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Product',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: imagePathController,
                  decoration: const InputDecoration(
                    labelText: 'Image Path',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: stockController,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final description = descriptionController.text;
                    final imagePath = imagePathController.text;
                    final stock = int.tryParse(stockController.text) ?? 1000;
                    if (name.isNotEmpty && description.isNotEmpty && imagePath.isNotEmpty) {
                      setState(() {
                        product.name = name;
                        product.description = description;
                        product.imagePath = imagePath;
                        product.stock = stock;
                      });

                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('All fields are required!')),
                      );
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteProduct(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  products.remove(product);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}


