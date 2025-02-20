import 'package:flutter/material.dart';
import 'package:personal_finance/widgets/statistics/statistics_card.dart';

class CategoriesChart extends StatelessWidget {
  const CategoriesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return StatisticsCard(
      child: Text('Chart'),
    );
  }
}
