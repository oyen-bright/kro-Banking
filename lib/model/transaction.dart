class Transaction {
  final String id;
  final DateTime dateTime;
  final String description;
  final double amount;
  final String type;
  final double balance;
  final String accountId;

  Transaction({
    required this.id,
    required this.dateTime,
    required this.description,
    required this.amount,
    required this.type,
    required this.balance,
    required this.accountId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? '',
      dateTime: DateTime.parse(json['date'] ?? ''),
      description: json['description'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      type: json['type'] ?? '',
      balance: (json['balance'] ?? 0.0).toDouble(),
      accountId: json['accountId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': dateTime.toIso8601String(),
      'description': description,
      'amount': amount,
      'type': type,
      'balance': balance,
      'accountId': accountId,
    };
  }

  bool get isDebit {
    return (amount.isNegative);
  }

  static Transaction get dummy {
    return Transaction(
      id: '1',
      dateTime: DateTime.now(),
      description: "**********",
      amount: 00000,
      type: 'Expense',
      balance: 500.0,
      accountId: 'XXXXXXXX',
    );
  }
}
