import 'package:flutter/material.dart';
import 'package:bank/model/transactions.dart';
import 'package:bank/service/transaction_service.dart';

class TransactionsProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  final TransactionService _transactionService = TransactionService();
  bool _isLoading = false;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;

  /// Load transactions for the user's card
  Future<void> loadTransactions(int cardId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _transactions = await _transactionService.getTransactions(cardId);
    } catch (e) {
      throw Exception("Failed to load transactions: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new transaction
  Future<void> addTransaction(Transaction newTransaction) async {
    try {
      await _transactionService.addTransaction(newTransaction);
      await loadTransactions(newTransaction.cardId); // Refresh the list
    } catch (e) {
      throw Exception("Failed to add transaction: $e");
    }
  }
}
