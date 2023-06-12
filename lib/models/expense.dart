class Expense {
  String? name;
  int? amount;
  String? timestamp;
  String? id;

  Expense({this.id, this.name, this.amount, this.timestamp});

  factory Expense.fromJson(Map<String, dynamic> json, String docId) {
    return Expense(
      id: docId,
      name: json['name'],
      amount: json['amount'],
      timestamp: json['timestamp'],
    );
  }
}
