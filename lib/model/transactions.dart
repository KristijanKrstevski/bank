class Transaction {
  int? id;
  int cardId;
  DateTime transactionDate;
  String description;

  Transaction({
    this.id,
    required this.cardId,
    required this.transactionDate,
    required this.description,
  });

  // Convert a Transaction into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'card_id': cardId,
      'transaction_date': transactionDate.toIso8601String(), // Ensure proper format
      'description': description,
    };
  }

  // Extract a Transaction object from a Map.
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      cardId: map['card_id'],
      transactionDate: map['transaction_date'] is String
          ? DateTime.parse(map['transaction_date'])
          : map['transaction_date'], // Handle both String & DateTime
      description: map['description'],
    );
  }
}
