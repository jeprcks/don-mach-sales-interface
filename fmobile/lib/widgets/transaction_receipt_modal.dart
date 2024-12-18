import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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

  Future<void> _printReceipt() async {
    final pdf = pw.Document();

    // Load a font that supports the Peso symbol
    final font = await PdfGoogleFonts.notoSansRegular();
    final boldFont = await PdfGoogleFonts.notoSansBold();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.all(8),
        build: (context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Center(
                  child: pw.Text(
                    'Transaction Receipt',
                    style: pw.TextStyle(
                      font: boldFont,
                      fontSize: 20,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    'Don Macchiatos',
                    style: pw.TextStyle(
                      font: boldFont,
                      fontSize: 16,
                    ),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    'Fuel your day, one cup at a time',
                    style: pw.TextStyle(font: font),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    DateFormat('MMMM dd, yyyy \'at\' hh:mm a')
                        .format(transactionDate),
                    style: pw.TextStyle(font: font),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Expanded(
                        child: pw.Text('Item',
                            style: pw.TextStyle(font: boldFont))),
                    pw.Expanded(
                        child: pw.Text('Qty',
                            style: pw.TextStyle(font: boldFont))),
                    pw.Expanded(
                        child: pw.Text('Price',
                            style: pw.TextStyle(font: boldFont))),
                    pw.Expanded(
                        child: pw.Text('Total',
                            style: pw.TextStyle(font: boldFont))),
                  ],
                ),
                pw.Divider(),
                ...orderList.map((item) {
                  final total = item['quantity'] * item['price'];
                  return pw.Row(
                    children: [
                      pw.Expanded(
                          child: pw.Text(item['name'],
                              style: pw.TextStyle(font: font))),
                      pw.Expanded(
                          child: pw.Text('${item['quantity']}',
                              style: pw.TextStyle(font: font))),
                      pw.Expanded(
                        child: pw.Text(
                          'P${item['price'].toStringAsFixed(2)}',
                          style: pw.TextStyle(font: font),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          'P${total.toStringAsFixed(2)}',
                          style: pw.TextStyle(font: font),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                pw.Divider(),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Total Amount:',
                        style: pw.TextStyle(font: boldFont)),
                    pw.Text(
                      'P${totalAmount.toStringAsFixed(2)}',
                      style: pw.TextStyle(font: boldFont),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Center(
                  child: pw.Text(
                    'Thank you for choosing Don Macchiatos!',
                    style: pw.TextStyle(font: font),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    'Please come again',
                    style: pw.TextStyle(font: font),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

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
              DateFormat('MMMM dd, yyyy \'at\' hh:mm a')
                  .format(transactionDate),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                    child: Text('Item',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('Qty',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('Price',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold))),
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
                    Expanded(
                        child: Text('₱${item['price'].toStringAsFixed(2)}')),
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
                  onPressed: _printReceipt,
                  icon: const Icon(Icons.print),
                  label: const Text(
                    'Print Receipt',
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
