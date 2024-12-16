import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionReceiptModal extends StatelessWidget {
  final List<Map<String, dynamic>> orderList;
  final double totalAmount;
  final DateTime transactionDate;

  const TransactionReceiptModal({
    super.key,
    required this.orderList,
    required this.totalAmount,
    required this.transactionDate,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Transaction Receipt',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B3025),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Don Macchiatos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B4226),
              ),
            ),
            const Text(
              'Fuel your day, one cup at a time',
              style: TextStyle(
                color: Color(0xFF6B4226),
              ),
            ),
            Text(
              DateFormat('MMMM dd, yyyy \'at\' hh:mm a').format(transactionDate),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                final item = orderList[index];
                final total = item['quantity'] * item['price'];
                return Row(
                  children: [
                    Expanded(child: Text(item['name'])),
                    Expanded(child: Text('${item['quantity']}')),
                    Expanded(child: Text('₱${item['price'].toStringAsFixed(2)}')),
                    Expanded(child: Text('₱${total.toStringAsFixed(2)}')),
                  ],
                );
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '₱${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Thank you for choosing Don Macchiatos!'),
            const Text('Please come again'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add print functionality here
                  },
                  icon: const Icon(Icons.print),
                  label: const Text('Print Receipt'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 