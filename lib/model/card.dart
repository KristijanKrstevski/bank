class Cards {
  int? id;
  String? userId;
  String transactionNumber;
  String expirationDate;
  int balance;
  int bankId;

  Cards({
    this.id,
    this.userId,//TUKAAAA TRGNAV REQURED
    required this.transactionNumber,
    required this.expirationDate,
    required this.balance,
    required this.bankId,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'transaction_number': transactionNumber,
      'expiration_date': expirationDate,
      'balance': balance,
      'bank_id': bankId,
    };
  }

  factory Cards.fromMap(Map<String, dynamic> map) {
    return Cards(
      id: map['id'],
      userId: map['user_id'],
      transactionNumber: map['transaction_number'],
      expirationDate: map['expiration_date'],
      balance: map['balance'],
      bankId: map['bank_id'],
    );
  }
}
