class Income {
  int? id;
  int transactionId;
  int amount;

  Income({
    this.id,
    required this.transactionId,
    required this.amount,
  });

  // Convert an Income into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'amount': amount,
    };
  }

  // Extract an Income object from a Map.
  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      transactionId: map['transaction_id'],
      amount: map['amount'],
    );
  }
}
