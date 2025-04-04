import 'package:flutter/material.dart';
import 'package:bank/service/income_service.dart';
import 'package:bank/model/income.dart';

class IncomeProvider with ChangeNotifier {
  final IncomeService _incomeService = IncomeService();
  List<Income> _incomes = [];
  bool _isLoading = false;

  List<Income> get incomes => _incomes;
  bool get isLoading => _isLoading;

  Future<void> loadIncomes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _incomes = await _incomeService.getIncomes();
    } catch (e) {
      throw Exception("Failed to load incomes: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addIncome(Income newIncome) async {
    try {
      await _incomeService.addIncome(newIncome);
      await loadIncomes();
    } catch (e) {
      throw Exception("Failed to add income: $e");
    }
  }
}