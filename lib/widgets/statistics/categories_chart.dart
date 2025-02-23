import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance/models/category_expense.dart';
import 'package:personal_finance/widgets/statistics/icon_chart_badge.dart';
import 'package:personal_finance/widgets/statistics/statistics_card.dart';

class CategoriesChart extends StatelessWidget {
  final List<CategoryExpense> categoryExpenses;
  const CategoriesChart({super.key, required this.categoryExpenses});

  @override
  Widget build(BuildContext context) {
    return StatisticsCard(
      child: Container(
        height: 300,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: PieChart(
          PieChartData(
            startDegreeOffset: -90,
            sections: categoryExpenses
                .map(
                  (expense) => PieChartSectionData(
                    value: expense.amount,
                    radius: 60,
                    color: expense.category.color,
                    titlePositionPercentageOffset: 0.4,
                    title: '${(expense.percent * 100).round()}%',
                    titleStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    badgePositionPercentageOffset: 1, // 0..1
                    badgeWidget: IconChartBadge(
                      iconData: expense.category.icon,
                      color: expense.category.color,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
