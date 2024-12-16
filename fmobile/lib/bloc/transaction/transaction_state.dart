import 'package:fmobile/bloc/transaction/transaction_bloc.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}
class TransactionLoading extends TransactionState {}
class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final TransactionSummary summary;

  TransactionLoaded(this.transactions, this.summary);
}
class TransactionError extends TransactionState {
  final String message;
  TransactionError(this.message);
} 