class Bill {
  final String id;
  final String name;
  final double amount;
  final DateTime dueDate;

  Bill({
    required this.id,
    required this.name,
    required this.amount,
    required this.dueDate,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      dueDate: DateTime.parse(json['dueDate'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  static Bill get dummy {
    return Bill(
        id: '1', name: '*************', amount: 150.0, dueDate: DateTime.now());
  }
}
