class ExpensesCategory {

  String category_name;
  String emoji;
 String? user_id;
 int? id;

  ExpensesCategory({
this.user_id,
    required this.category_name,
    required this.emoji,
     this.id,
  });

  // Convert an ExpensesCategory into a Map.
  Map<String, dynamic> toMap() {
    return {
   "category_user": user_id,
      'category_name': category_name,
      'emoji': emoji,
      "category_id": id,
    };
  }

  // Extract an ExpensesCategory object from a Map.
  factory ExpensesCategory.fromMap(Map<String, dynamic> map) {
    return ExpensesCategory(
      user_id: map['category_user'],
      category_name: map['category_name'],
      emoji: map['emoji'],
      id: map['category_id'],
    );
  }
}