
import 'package:bank/model/expenses_category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpencesCategoryService {
final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addExpenceCategory(ExpensesCategory expensesCategory) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception("User not logged in");
    }


    try {
      await _supabase.from("expenses_categories").insert({
       "category_user": userId,
      'category_name': expensesCategory.category_name,
      'emoji': expensesCategory.emoji,
      });
    } catch (e) {
      throw Exception("Failed to add expence: $e");
    }
  }

    Future<List<ExpensesCategory>> getExpensesCategory() async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    try {
      final response = await _supabase
          .from("expenses_categories")
          .select()
          .eq("category_user", userId);

      return response.map<ExpensesCategory>((data) {
        return ExpensesCategory(
         
          category_name: data['category_name'],
          emoji: data['emoji'],
        );
      }).toList();
    } catch (e) {
      throw Exception("Failed to load expenses categories: $e");
    }
  }
}