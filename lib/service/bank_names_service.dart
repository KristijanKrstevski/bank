import 'package:bank/model/bank_name.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BankNamesService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetches the bank name by its ID from the `bank_names` table.
  Future<String?> getBankNameById(int bankId) async {
    try {
      // Query the `bank_names` table for the row with the given `bankId`
      final response = await _supabase
          .from('bank_names')
          .select()
          .eq('id', bankId)
          .single();

      // Parse the response into a `BankName` object
      final bankName = BankName.fromMap(response);

      return bankName.bankName;
    } catch (e) {
      // Handle errors (e.g., no data found or network issues)
      print('Error fetching bank name: $e');
      return null;
    }
  }

  /// Fetches all banks from the `bank_names` table (optional).
  Future<List<BankName>> getAllBanks() async {
    try {
      // Query all rows from the `bank_names` table
      final response = await _supabase.from('bank_names').select();

      // Parse the response into a list of `BankName` objects
      final banks = (response as List)
          .map((bank) => BankName.fromMap(bank))
          .toList();

      return banks;
    } catch (e) {
      // Handle errors
      print('Error fetching all banks: $e');
      return [];
    }
  }
}