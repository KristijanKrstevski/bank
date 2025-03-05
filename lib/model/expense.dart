class Expense {
  int expenseId;
  int transactionId;
  int amount;
  int categoryId;
  Expense({
    required this.expenseId,
    required this.transactionId,
    required this.amount,
    required this.categoryId,
  });

  // Convert an Expense into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': expenseId,
      'transaction_id': transactionId,
      'amount': amount,
      'category_id': categoryId,
    };
  }

  // Extract an Expense object from a Map.
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      expenseId: map['id'],
      transactionId: map['transaction_id'],
      amount: map['amount'],
      categoryId: map['category_id'],
    );
  }
}
