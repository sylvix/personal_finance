import 'package:flutter/material.dart';
import 'package:personal_finance/models/category_expense.dart';
import 'package:personal_finance/widgets/category_display.dart';
import 'package:personal_finance/widgets/statistics/statistics_card.dart';

class CategoriesSummary extends StatelessWidget {
  final List<CategoryExpense> categoryExpenses;
  const CategoriesSummary({super.key, required this.categoryExpenses});

  @override
  Widget build(BuildContext context) {
    return StatisticsCard(
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categoryExpenses.length,
        itemBuilder: (ctx, index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryDisplay(category: categoryExpenses[index].category),
            Text('${categoryExpenses[index].amount.toStringAsFixed(2)} KGS'),
          ],
        ),
        separatorBuilder: (ctx, index) => SizedBox(height: 8),
      ),
    );
  }
}
