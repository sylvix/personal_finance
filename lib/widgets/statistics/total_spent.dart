import 'package:flutter/material.dart';
import 'package:personal_finance/widgets/statistics/statistics_card.dart';

class TotalSpent extends StatelessWidget {
  final double totalSpent;
  const TotalSpent({super.key, required this.totalSpent});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return StatisticsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total spent', style: textTheme.titleMedium),
          SizedBox(height: 8),
          Text(
            '${totalSpent.toStringAsFixed(2)} KGS',
            style: textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
