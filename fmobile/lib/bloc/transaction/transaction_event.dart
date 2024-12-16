abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {}

class SearchTransactions extends TransactionEvent {
  final String query;
  SearchTransactions(this.query);
}
