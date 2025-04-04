import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bank/model/transactions.dart';

class TransactionService {
  final SupabaseClient _supabase = Supabase.instance.client;

  
  Future<void> addTransaction(Transaction transaction) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw Exception("User not logged in.");
    }

   
    final response = await _supabase
        .from('cards')
        .select('id')
        .eq('id', transaction.cardId)
        .eq('user_id', userId)
        .maybeSingle(); 

    if (response == null) {
      throw Exception("Card not found or does not belong to the user.");
    }

 
    await _supabase.from('transactions').insert({
      'card_id': transaction.cardId,
      'transaction_date': transaction.transactionDate.toIso8601String(),
      
    });
     
  }

  Future<List<Transaction>> getTransactions(int cardId) async {
    final response = await _supabase
        .from('transactions')
        .select()
        .eq('card_id', cardId)
        .order('transaction_date', ascending: false);

    return response.map<Transaction>((map) => Transaction.fromMap(map)).toList();
  }
}
