import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
  ),
  Product(
    name: 'Black Forest',
    description:
        'A decadent symphony of flavors featuring luxurious Belgian dark chocolate and succulent Taiwanese strawberries, delicately infused with velvety milk',
    imagePath: 'assets/Productlist/blackforest.jpg',
  ),
  Product(
    name: 'Don Darko',
    description:
        'Crafted from the finest Belgian dark chocolate, harmoniously blended with creamy milk',
    imagePath: 'assets/Productlist/dondarko.jpg',
  ),
  Product(
    name: 'Donya Berry',
    description:
        'A tantalizing fusion of succulent Taiwanese strawberries mingled with creamy milk',
    imagePath: 'assets/Productlist/donyaberry.jpg',
  ),
  Product(
    name: 'Iced Caramel',
    description:
        'An exquisite blend of freshly pulled espresso, smooth milk, and luscious caramel syrup, served over a bed of ice',
    imagePath: 'assets/Productlist/icedcaramel.jpg',
  ),
  Product(
    name: 'Macha Berry',
    description:
        'A captivating harmony of Japanese matcha and Taiwanese strawberries, artfully intertwined with creamy milk',
    imagePath: 'assets/Productlist/matchaberry.jpg',
  ),
  Product(
    name: 'Macha',
    description:
        'A macchiato has steamed and frothed milk, and that foam goes on top of the shot of espresso or matcha.',
    imagePath: 'assets/Productlist/macha.jpg',
  ),

];

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<void> _selectImagePath(TextEditingController controller) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      controller.text = result.files.single.path ?? '';
    }
  }

  void _addProduct(String name, String description, String imagePath) {
    final nameExists = products.any((product) => product.name == name);

    if (nameExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed: Product name already exists!')),
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
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Image Path',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.folder),
                  ),
                  onTap: () => _selectImagePath(imagePathController),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final description = descriptionController.text;
                    final imagePath = imagePathController.text;

                    if (name.isNotEmpty &&
                        description.isNotEmpty &&
                        imagePath.isNotEmpty) {
                      _addProduct(name, description, imagePath);
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
    final descriptionController =
        TextEditingController(text: product.description);
    final imagePathController = TextEditingController(text: product.imagePath);

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
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Image Path',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.folder),
                  ),
                  onTap: () => _selectImagePath(imagePathController),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final description = descriptionController.text;
                    final imagePath = imagePathController.text;

                    if (name.isNotEmpty &&
                        description.isNotEmpty &&
                        imagePath.isNotEmpty) {
                      setState(() {
                        product.name = name;
                        product.description = description;
                        product.imagePath = imagePath;
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
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showEditProductForm(context, product),
                  child: const Text('Edit Product'),
                ),
                ElevatedButton(
                  onPressed: () => _deleteProduct(context, product),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductForm(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
