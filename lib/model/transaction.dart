class Transaction {
  final String id;
  final DateTime dateTime;
  final String description;
  final double amount;
  final String type;
  final double balance;

  Transaction({
    required this.id,
    required this.dateTime,
    required this.description,
    required this.amount,
    required this.type,
    required this.balance,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? '',
      dateTime: DateTime.parse(json['dateTime'] ?? ''),
      description: json['description'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      type: json['type'] ?? '',
      balance: (json['balance'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'description': description,
      'amount': amount,
      'type': type,
      'balance': balance,
    };
  }
}
