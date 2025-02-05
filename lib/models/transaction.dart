import 'package:personal_finance/data/categories_data.dart';
import 'package:personal_finance/models/transaction_category.dart';

class Transaction {
  final String title;
  final double amount;
  final DateTime dateTime;
  final String categoryId;

  Transaction({
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.categoryId,
  });

  String get formattedAmount {
    return '-${amount.toStringAsFixed(2)} KGS';
  }

  TransactionCategory get category {
    return categories.firstWhere((category) => category.id == categoryId);
  }
}
