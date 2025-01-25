import 'package:flutter/material.dart';
import 'package:personal_finance/models/transaction.dart';
import 'package:personal_finance/widgets/transaction_card.dart';

class TransactionsScreen extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionsScreen({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: transactions
            .map((transaction) => TransactionCard(transaction: transaction))
            .toList(),
      ),
    );
  }
}
