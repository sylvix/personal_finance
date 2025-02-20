import 'package:flutter/material.dart';
import 'package:personal_finance/helpers/format_datetime.dart';
import 'package:personal_finance/models/transaction.dart';
import 'package:personal_finance/widgets/category_display.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyLargeStyle = theme.textTheme.bodyLarge!;
    final titleSmallStyle = theme.textTheme.titleSmall!;
    final category = transaction.category;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.title,
                  style: bodyLargeStyle,
                ),
                Text(
                  transaction.formattedAmount,
                  style: bodyLargeStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryDisplay(category: category),
                Text(
                  formatDateTime(transaction.dateTime),
                  style: titleSmallStyle.copyWith(
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
