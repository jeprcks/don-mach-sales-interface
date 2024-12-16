import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/transaction_repository.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;

  TransactionBloc({required this.repository}) : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<SearchTransactions>(_onSearchTransactions);
  }

  void _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transactions = await repository.fetchTransactions();
      final summary = await repository.fetchTransactionSummary();
      emit(TransactionLoaded(transactions, summary));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  void _onSearchTransactions(
    SearchTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transactions = await repository.searchTransactions(event.query);
      final summary = await repository.fetchTransactionSummary();
      emit(TransactionLoaded(transactions, summary));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}

// Models
class Transaction {
  final String id;
  final DateTime date;
  final List<TransactionItem> items;
  final double total;
  final String status;

  Transaction({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
    required this.status,
  });
}

class TransactionItem {
  final String name;
  final int quantity;
  final double price;

  TransactionItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class TransactionSummary {
  final int totalTransactions;
  final double totalRevenue;
  final int totalItemsSold;

  TransactionSummary({
    required this.totalTransactions,
    required this.totalRevenue,
    required this.totalItemsSold,
  });
} 