import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bank/model/card.dart';

class CardService {
  final SupabaseClient _supabase = Supabase.instance.client;


  Future<void> addCard(Cards newCard) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    try {
      await _supabase
      .from("cards").insert({
        'user_id': userId,
        'transaction_number': newCard.transactionNumber,
        'expiration_date': newCard.expirationDate,
        'balance': newCard.balance,
        'bank_id': newCard.bankId,
      });
    } catch (e) {
      throw Exception("Failed to add card: $e");
    }
  }


 Future<List<Cards>> getCards() async {
  final userId = _supabase.auth.currentUser?.id;

  if (userId == null) {
    throw Exception("User not logged in");
  }

  try {
    final data = await _supabase
        .from("cards")
        .select()
        .eq('user_id', userId);

    return data.map((cardMap) {
      return Cards(
        id: cardMap['id'],
        userId: cardMap['user_id'], 
        transactionNumber: cardMap['transaction_number'] as String,
        expirationDate: cardMap['expiration_date'] as String,
        balance: int.tryParse(cardMap['balance'].toString()) ?? 0, // Convert to int
        bankId: int.tryParse(cardMap['bank_id'].toString()) ?? 0, // Convert to int
      );
    }).toList();
  } catch (e) {
    throw Exception("Failed to fetch cards: $e");
  }
}
 Future<void> updateCard(Cards card) async {
  if (card.id == null) {
    throw Exception("Card ID is required for update");
  }

  try {
    await _supabase
        .from("cards")
        .update(card.toMap())
        .eq('id', card.id!);
  } catch (e) {
    throw Exception("Failed to update card: $e");
  }
}

Future<void> deleteCard(Cards card) async {
  if (card.id == null) {
    throw Exception("Card ID is required for deletion");
  }

  try {
    await _supabase
        .from("cards")
        .delete()
        .eq('id', card.id!);
  } catch (e) {
    throw Exception("Failed to delete card: $e");
  }
}
}