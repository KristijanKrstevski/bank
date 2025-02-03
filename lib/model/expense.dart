class Expense {
  int? id;
  int transactionId;
  int amount;

  Expense({
    this.id,
    required this.transactionId,
    required this.amount,
  });

  // Convert an Expense into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'amount': amount,
    };
  }

  // Extract an Expense object from a Map.
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      transactionId: map['transaction_id'],
      amount: map['amount'],
    );
  }
}
