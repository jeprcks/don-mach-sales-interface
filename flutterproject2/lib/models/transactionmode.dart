class Transaction {
  final int orderNumber;
  final List<Map<String, dynamic>> orderList;
  final double totalPrice;
  final DateTime date;
  Transaction({
    required this.orderNumber,
    required this.orderList,
    required this.totalPrice,
    required this.date,
  });
}

// Global list to store transactions
List<Transaction> transactionHistory = [];
int currentOrderNumber = 1; // Start the order number from 1