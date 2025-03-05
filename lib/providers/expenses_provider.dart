import 'package:flutter/material.dart';
import 'package:bank/service/expenses_service.dart';


import 'package:bank/model/expense.dart';

class ExpensesProvider with ChangeNotifier {

   final ExpencesService _expensesService = ExpencesService();
  List<Expense> _expenses = [];
  bool _isLoading = false;

  List<Expense> get categories => _expenses;
  bool get isLoading => _isLoading;

  Future<void> loadExpenses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _expenses = await _expensesService.getExpences();
    } catch (e) {
      throw Exception("Failed to load cards: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> addExpence(Expense newExpense) async {
    try {
      await _expensesService.addExpence(newExpense);
       await loadExpenses(); 
    } catch (e) {
      throw Exception("Failed to add expense: $e");
    }
  }
}
