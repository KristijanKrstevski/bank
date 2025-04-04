class Transaction {
  int? id;
  int cardId;
  DateTime transactionDate;
 

  Transaction({
    this.id,
    required this.cardId,
    required this.transactionDate,
    
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'card_id': cardId,
      'transaction_date': transactionDate.toIso8601String(),
    
    };
  }


  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      cardId: map['card_id'],
      transactionDate: map['transaction_date'] is String
          ? DateTime.parse(map['transaction_date'])
          : map['transaction_date'], 
   
    );
  }
}
