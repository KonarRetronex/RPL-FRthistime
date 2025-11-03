import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  final Box<TransactionModel> _transactionBox = Hive.box('transactions');

  List<TransactionModel> _transactions = [];
  
  // Getter yang di-sortir
  List<TransactionModel> get transactions {
    // Selalu sortir list sebelum mengembalikannya
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    return _transactions;
  }
  
  TransactionProvider() {
    loadTransactions();
  }

  void loadTransactions() {
    _transactions = _transactionBox.values.toList().cast<TransactionModel>();
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel tx) async {
    await _transactionBox.put(tx.id, tx);
    loadTransactions(); // Memuat ulang dan memberi notifikasi
  }

  Future<void> deleteTransaction(String id) async {
    await _transactionBox.delete(id);
    loadTransactions();
  }

  // Kalkulasi untuk Dashboard
  double get totalIncome {
    return _transactions
        .where((tx) => tx.type == TransactionType.income)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return _transactions
        .where((tx) => tx.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalBalance {
    return totalIncome - totalExpense;
  }
}