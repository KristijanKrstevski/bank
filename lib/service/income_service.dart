import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bank/model/income.dart';

class IncomeService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addIncome(Income income) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");


    final cardResponse = await _supabase
        .from('cards')
        .select('id')
        .eq('id', income.transactionId)
        .eq('user_id', userId)
        .maybeSingle();

    if (cardResponse == null) {
      throw Exception("Card not found or doesn't belong to user");
    }

    try {
      await _supabase.from('income').insert({
        'transaction_id': income.transactionId,
        'amount': income.amount,
      });

 await _supabase.rpc(
  'increment_balance',
  params: {
    'card_id': income.transactionId,
    'amount': income.amount,
  },
);


    } catch (e) {
      throw Exception("Failed to add income: $e");
    }
  }

  Future<List<Income>> getIncomes() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");

    try {
      final response = await _supabase
          .from('income')
          .select('''
            *,
            cards!inner(user_id)
          ''')
          .eq('cards.user_id', userId);

      return response.map<Income>((data) {
        return Income(
          id: data['id'],
          transactionId: data['transaction_id'],
          amount: data['amount'],
          incomeDate: data['income_date'] == null
              ? null
              : DateTime.parse(data['income_date'] as String),
        );
      }).toList();
    } catch (e) {
      throw Exception("Failed to load incomes: $e");
    }
  }
}