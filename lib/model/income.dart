class Income {
  int? id;
  int transactionId;
  int amount;
  DateTime? incomeDate;

  Income({
    this.id,
    required this.transactionId,
    required this.amount,
    this.incomeDate,
  });

 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'amount': amount,
      'income_date': incomeDate?.toIso8601String(),
    };
  }

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      transactionId: map['transaction_id'],
      amount: map['amount'],
      incomeDate: map['income_date'] == null
          ? null
          : DateTime.parse(map['income_date'] as String),
    );
  }
}
