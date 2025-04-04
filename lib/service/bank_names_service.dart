import 'package:bank/model/bank_name.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BankNamesService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> getBankNameById(int bankId) async {
    try {
      
      final response = await _supabase
          .from('bank_names')
          .select('bank_name')
          .eq('id', bankId)
          .single();

     
      final bankName = BankName.fromMap(response);

      return bankName.bankName;
    } catch (e) {
  
      print('Error fetching bank name: $e');
      return null;
    }
  }

  Future<List<BankName>> getAllBanks() async {
    try {
   
      final response = await _supabase.from('bank_names').select();

      final banks = (response as List)
          .map((bank) => BankName.fromMap(bank))
          .toList();

      return banks;
    } catch (e) {
    
      print('Error fetching all banks: $e');
      return [];
    }
  }
}