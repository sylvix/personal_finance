class Transaction {
  final String title;
  final double amount;
  final DateTime dateTime;

  Transaction({
    required this.title,
    required this.amount,
    required this.dateTime,
  });

  String get formattedAmount {
    return '-${amount.toStringAsFixed(2)} KGS';
  }
}
