class Expense {
  int? expenseId;
  int transactionId;
  int amount;
  int categoryId;
  DateTime? expenseDate;
  Expense({
     this.expenseId,
    required this.transactionId,
    required this.amount,
    required this.categoryId,
    this.expenseDate,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': expenseId,
      'transaction_id': transactionId,
      'amount': amount,
      'category_id': categoryId,
      'expense_date': expenseDate?.toIso8601String(),
    };
  }


  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      expenseId: map['id'],
      transactionId: map['transaction_id'],
      amount: map['amount'],
      categoryId: map['category_id'],
      expenseDate: map['expense_date'] == null
          ? null
          : DateTime.parse(map['expense_date'] as String),
    );
  }
}
