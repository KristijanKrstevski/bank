import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bank/model/expense.dart';

class ExpencesService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addExpence(Expense expense) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");


    final cardResponse = await _supabase
        .from('cards')
        .select('id')
        .eq('id', expense.transactionId)
        .eq('user_id', userId)
        .maybeSingle();

    if (cardResponse == null) {
      throw Exception("Card not found or does not belong to the user.");
    }

    try {
      await _supabase.from('expense').insert({
        'transaction_id': expense.transactionId,
        'amount': expense.amount,
        'category_id': expense.categoryId,
      });
       await _supabase.rpc(
      'decrement_balance',
      params: {
        'card_id': expense.transactionId,
        'amount': expense.amount,
      },
    );
    } catch (e) {
      throw Exception("Failed to add expense: $e");
    }
  }

  Future<List<Expense>> getExpences() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");

    try {
      final response = await _supabase
          .from('expense')
          .select('''
            *,
            cards!inner(user_id)
          ''')
          .eq('cards.user_id', userId);

      return response.map<Expense>((data) {
        return Expense(
          expenseId: data['id'],
          transactionId: data['transaction_id'],
          amount: data['amount'],
          categoryId: data['category_id'],
          expenseDate: data['expense_date'] == null
              ? null
              : DateTime.parse(data['expense_date'] as String),
        );
      }).toList();
    } catch (e) {
      throw Exception("Failed to load expenses: $e");
    }
  }
}