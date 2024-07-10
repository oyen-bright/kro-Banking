class Bill {
  final String id;
  final String name;
  final bool reoccurring;
  final double amount;
  final String status;
  final DateTime dueDate;
  final bool completed;

  Bill({
    required this.reoccurring,
    required this.status,
    required this.id,
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.completed,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      status: json['status'],
      reoccurring: json['reoccurring'] ?? false,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      dueDate: DateTime.parse(json['dueDate'] ?? ''),
      completed: json['completed'] ?? false,
    );
  }

  static Bill get dummy {
    return Bill(
        reoccurring: true,
        status: 'pending',
        id: "id",
        name: '********',
        amount: 00,
        dueDate: DateTime.now(),
        completed: false);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'id': id,
      'name': name,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'reoccurring': reoccurring,
      'completed': completed,
    };
  }

  bool get isPending {
    return status == "pending";
  }
}
