class Account {
  final String id;
  final String type;
  final double balance;

  Account({
    required this.id,
    required this.type,
    required this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      balance: (json['balance'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'balance': balance,
    };
  }
}
