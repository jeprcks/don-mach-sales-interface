import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../bloc/transaction/transaction_bloc.dart';

class TransactionRepository {
  final _secureStorage = const FlutterSecureStorage();

  Future<List<Transaction>> fetchTransactions() async {
    final token = await _secureStorage.read(key: 'token');
    final userId = await _secureStorage.read(key: 'userId');

    if (token == null || userId == null) {
      throw Exception('Authentication required');
    }

    try {
      final response = await http.get(
        Uri.parse('http://localhost:8000/api/sales/$userId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((transaction) {
          final orderList = transaction['order_list'] is String
              ? jsonDecode(transaction['order_list']) as List<dynamic>
              : transaction['order_list'] as List<dynamic>;

          return Transaction(
            id: transaction['id'].toString(),
            date: DateTime.parse(transaction['created_at']),
            items: orderList.map((item) {
              return TransactionItem(
                name: item['name'],
                quantity: item['quantity'],
                price: double.parse(item['price'].toString()),
              );
            }).toList(),
            total: double.parse(transaction['total_order'].toString()),
            status: transaction['status'] ?? 'Completed',
          );
        }).toList();
      } else {
        throw Exception('Failed to fetch transactions');
      }
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  Future<TransactionSummary> fetchTransactionSummary() async {
    final transactions = await fetchTransactions();

    int totalTransactions = transactions.length;
    double totalRevenue = transactions.fold(0, (sum, t) => sum + t.total);
    int totalItemsSold = transactions.fold(
        0,
        (sum, t) =>
            sum + t.items.fold(0, (itemSum, item) => itemSum + item.quantity));

    return TransactionSummary(
      totalTransactions: totalTransactions,
      totalRevenue: totalRevenue,
      totalItemsSold: totalItemsSold,
    );
  }

  Future<List<Transaction>> searchTransactions(String query) async {
    final transactions = await fetchTransactions();
    return transactions.where((transaction) {
      return transaction.items
          .any((item) => item.name.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }
}
