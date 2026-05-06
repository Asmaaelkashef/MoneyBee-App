import 'package:MoneyBee/Cubits/Transaction Cubit/states.dart';
import 'package:MoneyBee/Data/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCubit extends Cubit<TransactionStates> {
  TransactionCubit() : super(TransactionInitialState());
  final DataBase _db = DataBase();
  bool isExpense = true;
  double amount = 0.0;
  DateTime date = DateTime.now();
  String notes = '';
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double balance = 0.0;
  Map<String, double> expensesByMonth = {};

  void setType(bool expense) {
    isExpense = expense;
    emit(TransactionTypeState(isExpense: isExpense));
  }

  void setAmount(double value) {
    amount = value;
    emit(TransactionAmountState(amount: amount));
  }

  void setDate(DateTime value) {
    date = value;
    emit(TransactionDateState(date: date));
  }

  void setNotes(String value) {
    notes = value;
    emit(TransactionNotesState(notes: notes));
  }

  Future<void> saveTransaction() async {
    await _db.insertData('''
      INSERT INTO transactions (amount, isExpense, date, notes)
      VALUES ($amount, ${isExpense ? 1 : 0}, '${date.toIso8601String()}', '$notes')
    ''');
    emit(TransactionSavedState());
    reset();
  }

  List<Map<String, dynamic>> transactions = [];

  Future<void> getTransactions() async {
    final result = await _db.readData(
      'SELECT * FROM transactions ORDER BY date DESC',
    );
    transactions = result;
    emit(TransactionLoadedState(transactions: transactions));
  }

  List<Map<String, dynamic>> recentTransactions = [];

  Future<void> getRecentTransactions() async {
    final result = await _db.readData(
      'SELECT * FROM transactions ORDER BY date DESC LIMIT 5',
    );
    recentTransactions = result;
    emit(TransactionLoadedState(transactions: recentTransactions));
  }

  Future<void> getTotals() async {
    final income = await _db.readData(
      'SELECT SUM(amount) as total FROM transactions WHERE isExpense = 0',
    );
    final expense = await _db.readData(
      'SELECT SUM(amount) as total FROM transactions WHERE isExpense = 1',
    );

    totalIncome = income[0]['total'] ?? 0.0;
    totalExpense = expense[0]['total'] ?? 0.0;
    emit(
      TransactionTotalsState(
        totalIncome: totalIncome,
        totalExpense: totalExpense,
      ),
    );
  }

  Future<void> deleteTransaction(int id) async {
    await _db.deleteData('DELETE FROM transactions WHERE id = $id');
    await getTransactions();
    await getRecentTransactions();
    await getTotals();
  }

  Future<void> getStatistics() async {
    balance = totalIncome - totalExpense;

    final result = await _db.readData('''
    SELECT strftime('%m/%Y', date) as month, SUM(amount) as total
    FROM transactions
    WHERE isExpense = 1
    GROUP BY month
    ORDER BY date DESC
  ''');

    expensesByMonth = {};

    for (var row in result) {
      String month = row['month'];
      double total = row['total'];
      expensesByMonth[month] = total;
    }

    emit(TransactionStatisticsState());
  }

  void reset() {
    isExpense = true;
    amount = 0.0;
    date = DateTime.now();
    notes = '';
    emit(TransactionInitialState());
  }
}
