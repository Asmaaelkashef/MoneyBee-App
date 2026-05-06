abstract class TransactionStates {}

class TransactionInitialState extends TransactionStates {}

class TransactionTypeState extends TransactionStates {
  final bool isExpense;
  TransactionTypeState({required this.isExpense});
}

class TransactionAmountState extends TransactionStates {
  final double amount;
  TransactionAmountState({required this.amount});
}

class TransactionDateState extends TransactionStates {
  final DateTime date;
  TransactionDateState({required this.date});
}

class TransactionLoadedState extends TransactionStates {
  final List<Map<String, dynamic>> transactions;
  TransactionLoadedState({required this.transactions});
}

class TransactionNotesState extends TransactionStates {
  final String notes;
  TransactionNotesState({required this.notes});
}

class TransactionSavedState extends TransactionStates {}

class TransactionTotalsState extends TransactionStates {
  final double totalIncome;
  final double totalExpense;
  TransactionTotalsState({required this.totalIncome, required this.totalExpense});
}

class TransactionStatisticsState extends TransactionStates {}

