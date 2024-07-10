// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  static Account get dummy {
    return Account(id: '1', type: '*********', balance: 0000.0);
  }

  Account copyWith({
    String? id,
    String? type,
    double? balance,
  }) {
    return Account(
      id: id ?? this.id,
      type: type ?? this.type,
      balance: balance ?? this.balance,
    );
  }
}
