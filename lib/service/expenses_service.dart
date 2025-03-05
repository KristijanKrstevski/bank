import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bank/model/expense.dart';
class ExpencesService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addExpence(Expense expense) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception("User not logged in");
    }


  final response = await _supabase
        .from('transactions')
        .select('id') 
        .eq('id', expense.expenseId)
        .eq('user_id', userId)
        .maybeSingle(); 

if (response == null) {
      throw Exception("Transaction not found or does not belong to the user.");
    }

    try {
      await _supabase.from("expences").insert({
        'id': expense.expenseId,
        'transaction_id': expense.transactionId,
        'amount': expense.amount,
        'category_id': expense.categoryId,
      });
    } catch (e) {
      throw Exception("Failed to add expence: $e");
    }
  }
  Future<List<Expense>> getExpences() async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    try {
      final response = await _supabase
          .from("expense")
          .select()
          .eq("user_id", userId);

      return response.map<Expense>((data) {
        return Expense(
          expenseId: data['id'],
          transactionId: data['transaction_id'],
          amount: data['amount'],
          categoryId: data['category_id'],
        );
      }).toList();
    }catch (e) {
      throw Exception("Failed to load expenses: $e");
    }
  }
}