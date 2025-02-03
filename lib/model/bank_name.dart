class BankName {
  int? id;
  String bankName;

  BankName({
    this.id,
    required this.bankName,
  });

  // Convert a BankName into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bank_name': bankName,
    };
  }

  // Extract a BankName object from a Map.
  factory BankName.fromMap(Map<String, dynamic> map) {
    return BankName(
      id: map['id'],
      bankName: map['bank_name'],
    );
  }
}
