import 'package:personal_finance/models/transaction_category.dart';

class CategoryExpense {
  final TransactionCategory category;
  final double amount;
  final double percent; // 0..1

  CategoryExpense({
    required this.category,
    required this.amount,
    required this.percent,
  });
}
