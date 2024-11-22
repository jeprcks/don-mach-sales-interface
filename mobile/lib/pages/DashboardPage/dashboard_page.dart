// import 'package:flutter/material.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
          
//           title: const Text(
            
//             'Dashboard',
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            
//           ),
//           backgroundColor: Colors.brown,
//           centerTitle: true,
//           bottom: const TabBar(
//           labelColor: Colors.black, // Active tab text color
//           unselectedLabelColor: Colors.black54, // Inactive tab text color
//           indicatorColor: Colors.black, // Tab indicator color
//             tabs: [
//               Tab(icon: Icon(Icons.coffee), text: 'Stock'),
//               Tab(icon: Icon(Icons.trending_up), text: 'Sales'),
//               Tab(icon: Icon(Icons.bar_chart), text: 'Performance'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             StockManagementTab(),
//             SalesTrendsTab(),
//             ProductPerformanceTab(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Stock Management Tab
// class StockManagementTab extends StatefulWidget {
//   const StockManagementTab({super.key});

//   @override
//   _StockManagementTabState createState() => _StockManagementTabState();
// }

// class _StockManagementTabState extends State<StockManagementTab> {
//   final Map<String, int> stockLevels = {
//     'Espresso': 1000,
//     'Latte': 1000,
//     'Cappuccino': 1000,
//     'Macchiato': 1000,
//     'Americano': 1000,
//   };

//   final TextEditingController coffeeNameController = TextEditingController();
//   final TextEditingController coffeeStockController = TextEditingController();

//   void addNewCoffee() {
//     final name = coffeeNameController.text.trim();
//     final stock = int.tryParse(coffeeStockController.text.trim()) ?? 0;

//     if (name.isNotEmpty && stock > 0) {
//       setState(() {
//         stockLevels[name] = stock;
//       });
//       coffeeNameController.clear();
//       coffeeStockController.clear();
//     }
//   }

//   void updateStock(String coffee, int newStock) {
//     setState(() {
//       stockLevels[coffee] = newStock;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Manage Coffee Stock',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16.0),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: coffeeNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Coffee Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8.0),
//               Expanded(
//                 child: TextField(
//                   controller: coffeeStockController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Stock',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.add),
//                 onPressed: addNewCoffee,
//               ),
//             ],
//           ),
//           const SizedBox(height: 16.0),
//           Expanded(
//             child: ListView.builder(
//               itemCount: stockLevels.length,
//               itemBuilder: (context, index) {
//                 final coffee = stockLevels.keys.elementAt(index);
//                 final stock = stockLevels[coffee]!;
//                 final isLowStock = stock < 50;

//                 return ListTile(
//                   title: Text(coffee),
//                   subtitle: isLowStock
//                       ? const Text(
//                           'Need to restock',
//                           style: TextStyle(color: Colors.red),
//                         )
//                       : null,
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text('Stock: $stock'),
//                       const SizedBox(width: 8.0),
//                       IconButton(
//                         icon: const Icon(Icons.edit),
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (_) {
//                               final controller =
//                                   TextEditingController(text: stock.toString());
//                               return AlertDialog(
//                                 title: Text('Update Stock for $coffee'),
//                                 content: TextField(
//                                   controller: controller,
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                     labelText: 'New Stock',
//                                   ),
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       final newStock =
//                                           int.tryParse(controller.text) ?? stock;
//                                       updateStock(coffee, newStock);
//                                       Navigator.pop(context);
//                                     },
//                                     child: const Text('Update'),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Sales Trends Tab
// class SalesTrendsTab extends StatelessWidget {
//   const SalesTrendsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, double> salesTrends = {
//       'Daily': 5000.0,
//       'Weekly': 35000.0,
//       'Monthly': 150000.0,
//     };

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Sales Trends',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16.0),
//           Expanded(
//             child: ListView(
//               children: salesTrends.entries.map((entry) {
//                 return ListTile(
//                   title: Text(entry.key),
//                   trailing: Text('₱${entry.value.toStringAsFixed(2)}'),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Product Performance Tab
// class ProductPerformanceTab extends StatelessWidget {
//   const ProductPerformanceTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, double> productPerformance = {
//       'Espresso': 12000.0,
//       'Latte': 15000.0,
//       'Cappuccino': 18000.0,
//       'Macchiato': 8000.0,
//     };

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Product Performance',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16.0),
//           Expanded(
//             child: ListView(
//               children: productPerformance.entries.map((entry) {
//                 return ListTile(
//                   title: Text(entry.key),
//                   trailing: Text('₱${entry.value.toStringAsFixed(2)}'),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
