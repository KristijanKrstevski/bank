import 'package:flutter/material.dart';
import 'package:bank/model/bank_name.dart';
import 'package:bank/service/bank_names_service.dart';

class BankNameProvider with ChangeNotifier {
  final BankNamesService _bankNamesService = BankNamesService();
  List<BankName> _banks = [];
  bool _isLoading = false;

  List<BankName> get banks => _banks;
  bool get isLoading => _isLoading;

  Future<void> loadBanks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _banks = await _bankNamesService.getAllBanks();
    } catch (e) {
      throw Exception("Failed to load banks: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> getBankNameById(int bankId) async {
    try {
      return await _bankNamesService.getBankNameById(bankId);
    } catch (e) {
      throw Exception("Failed to fetch bank name: $e");
    }
  }
}