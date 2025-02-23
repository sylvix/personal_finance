import 'package:flutter/material.dart';
import 'package:personal_finance/models/transaction_category.dart';

class CategoryDisplay extends StatelessWidget {
  final TransactionCategory category;
  const CategoryDisplay({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleSmallStyle = theme.textTheme.titleSmall!;

    return Row(
      children: [
        Icon(
          category.icon,
          size: 16,
          color: category.color,
        ),
        SizedBox(width: 4),
        Text(category.title, style: titleSmallStyle),
      ],
    );
  }
}
