import 'package:flutter/material.dart';
import 'package:personal_finance/data/categories_data.dart';
import 'package:personal_finance/models/category_expense.dart';
import 'package:personal_finance/models/transaction.dart';
import 'package:personal_finance/widgets/statistics/categories_chart.dart';
import 'package:personal_finance/widgets/statistics/categories_summary.dart';
import 'package:personal_finance/widgets/statistics/statistics_container.dart';
import 'package:personal_finance/widgets/statistics/total_spent.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Transaction> transactions;
  const StatisticsScreen({super.key, required this.transactions});

  double get totalSpent {
    return transactions.fold(0, (prev, t) => prev + t.amount);
  }

  List<CategoryExpense> get categoryExpenses {
    final total = totalSpent;

    final expenses = categories.map((category) {
      final transactionsOfCategory =
          transactions.where((t) => t.categoryId == category.id);
      final amount =
          transactionsOfCategory.fold(0.0, (prev, t) => prev + t.amount);
      final percent = amount / total;
      return CategoryExpense(
        category: category,
        amount: amount,
        percent: percent,
      );
    }).toList();

    expenses.sort((a, b) => a.amount > b.amount ? -1 : 1);
    return expenses;
  }

  @override
  Widget build(BuildContext context) {
    return StatisticsContainer(
      child: Column(
        children: [
          TotalSpent(totalSpent: totalSpent),
          CategoriesChart(),
          CategoriesSummary(categoryExpenses: categoryExpenses),
        ],
      ),
    );
  }
}
