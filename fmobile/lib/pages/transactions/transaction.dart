import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fmobile/bloc/transaction/transaction_event.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../bloc/transaction/transaction_bloc.dart';
import '../../bloc/transaction/transaction_state.dart';
import '../../repositories/transaction_repository.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(
        repository: TransactionRepository(),
      )..add(LoadTransactions()),
      child: const TransactionView(),
    );
  }
}

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  String searchTerm = '';
  bool newestFirst = true;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en_PH');
    tz.initializeTimeZones();
  }

  List<Transaction> _filterAndSortTransactions(List<Transaction> transactions) {
    return transactions.where((transaction) {
      final searchLower = searchTerm.toLowerCase();
      final dateString = DateFormat('MMMM dd, yyyy').format(transaction.date);

      return dateString.toLowerCase().contains(searchLower) ||
          transaction.items
              .any((item) => item.name.toLowerCase().contains(searchLower));
    }).toList()
      ..sort((a, b) =>
          newestFirst ? b.date.compareTo(a.date) : a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/homepage'),
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF795548),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransactionError) {
            return Center(child: Text(state.message));
          }

          if (state is TransactionLoaded) {
            final filteredTransactions =
                _filterAndSortTransactions(state.transactions);

            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search by product name or date...',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    searchTerm = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            DropdownButton<String>(
                              value:
                                  newestFirst ? 'Newest First' : 'Oldest First',
                              items: ['Newest First', 'Oldest First']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  newestFirst = newValue == 'Newest First';
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction = filteredTransactions[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ExpansionTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat(
                                              'MMM dd, yyyy h:mm a', 'en_PH')
                                          .format(tz.TZDateTime.from(
                                              transaction.date,
                                              tz.getLocation('Asia/Manila'))),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'Completed',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '₱${transaction.total.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Order Details:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Table(
                                          columnWidths: const {
                                            0: FlexColumnWidth(2),
                                            1: FlexColumnWidth(1),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(1),
                                          },
                                          children: [
                                            const TableRow(
                                              children: [
                                                Text('Item'),
                                                Text('Qty'),
                                                Text('Price'),
                                                Text('Subtotal'),
                                              ],
                                            ),
                                            ...transaction.items.map((item) {
                                              return TableRow(
                                                children: [
                                                  Text(item.name),
                                                  Text('${item.quantity}'),
                                                  Text(
                                                      '₱${item.price.toStringAsFixed(2)}'),
                                                  Text(
                                                      '₱${(item.price * item.quantity).toStringAsFixed(2)}'),
                                                ],
                                              );
                                            }),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Total Items: ${transaction.items.length}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  color: const Color(0xFF795548),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaction Summary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildSummaryCard(
                        'Total Transactions',
                        state.transactions.length.toString(),
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryCard(
                        'Total Revenue',
                        '₱${_calculateTotalRevenue(state.transactions).toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryCard(
                        'Total Items Sold',
                        _calculateTotalItems(state.transactions).toString(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('No transactions found'));
        },
      ),
    );
  }

  double _calculateTotalRevenue(List<Transaction> transactions) {
    return transactions.fold(0, (sum, transaction) => sum + transaction.total);
  }

  int _calculateTotalItems(List<Transaction> transactions) {
    return transactions.fold(
        0,
        (sum, transaction) =>
            sum +
            transaction.items
                .fold(0, (itemSum, item) => itemSum + item.quantity));
  }

  Widget _buildSummaryCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF795548),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF795548),
            ),
          ),
        ],
      ),
    );
  }
}
