class BankName {
  int? id;
  String bankName;

  BankName({
    this.id,
    required this.bankName,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bank_name': bankName,
    };
  }


  factory BankName.fromMap(Map<String, dynamic> map) {
    return BankName(
      id: map['id'],
      bankName: map['bank_name'],
    );
  }
}
