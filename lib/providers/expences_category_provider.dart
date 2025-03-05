import 'package:bank/service/expenses_category_service.dart';
import 'package:flutter/material.dart';

import 'package:bank/model/expenses_category.dart';

class ExpencesCategoryProvider extends ChangeNotifier {

 final ExpencesCategoryService _expensesCategoryService = ExpencesCategoryService();
  List<ExpensesCategory> _categories = [];
  bool _isLoading = false;

  List<ExpensesCategory> get categories => _categories;
  bool get isLoading => _isLoading;


  Future<void> loadExpensesCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _expensesCategoryService.getExpensesCategory();
    } catch (e) {
      throw Exception("Failed to load cattegory expenses: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> addExpenceCategory(ExpensesCategory newExpenseCategory) async {
    try {
      await _expensesCategoryService.addExpenceCategory(newExpenseCategory);
       await loadExpensesCategories(); // Refresh the list
    } catch (e) {
      throw Exception("Failed to add cateogry expence: $e");
    }
  }

}
