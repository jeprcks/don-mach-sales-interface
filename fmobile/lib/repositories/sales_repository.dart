import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SalesRepository {
  final _secureStorage = const FlutterSecureStorage();

  Future<List<dynamic>> fetchProducts() async {
    final token = await _secureStorage.read(key: 'token');
    final userId = await _secureStorage.read(key: 'userId');

    if (token == null || userId == null) {
      throw Exception('Authentication required');
    }

    final response = await http.get(
      Uri.parse('http://localhost:8000/api/products/$userId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<Map<String, dynamic>> createSale(
      List<Map<String, dynamic>> orderList, double totalOrder) async {
    final token = await _secureStorage.read(key: 'token');
    final userId = await _secureStorage.read(key: 'userId');

    if (token == null || userId == null) {
      throw Exception('Authentication required');
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/createSales'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'user_id': userId,
          'order_list': orderList,
          'total_order': totalOrder,
          'quantity':
              orderList.fold(0, (sum, item) => sum + (item['quantity'] as int)),
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Failed to create sale');
      }
    } catch (e) {
      if (e.toString().contains('Sale created successfully')) {
        // This is actually a success case
        return {'status': 'success', 'message': 'Sale created successfully'};
      }
      throw Exception('Failed to create sale: $e');
    }
  }
}
