class ExpensesCategory {

 final int id;
  final String category_name;
  final String emoji;
  final String user_id; 

  ExpensesCategory({
    required this.user_id,
    required this.category_name,
    required this.emoji,
    required this.id,
  });

  factory ExpensesCategory.fromMap(Map<String, dynamic> map) {
    return ExpensesCategory(
      user_id: map['category_user'].toString(), 
      category_name: map['category_name'] as String,
      emoji: map['emoji'] as String,
      id: int.parse(map['category_id'].toString()), 
    );
  }

  Map<String, dynamic> toMap() {
    return {
   "category_user": user_id,
      'category_name': category_name,
      'emoji': emoji,
      "category_id": id,
    };
  }


}