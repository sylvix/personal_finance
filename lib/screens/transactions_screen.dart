import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:personal_finance/models/transaction.dart';
import 'package:personal_finance/widgets/transaction_card.dart';

class TransactionsScreen extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) onTransactionDeleted;
  final void Function(String id) onTransactionEdited;

  const TransactionsScreen({
    super.key,
    required this.transactions,
    required this.onTransactionDeleted,
    required this.onTransactionEdited,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final transaction = transactions[index];
          return Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.4,
              motion: DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (ctx) => onTransactionDeleted(transaction.id),
                  icon: Icons.delete,
                  backgroundColor: theme.colorScheme.error.withAlpha(220),
                  label: 'Delete',
                  padding: EdgeInsets.zero,
                ),
                SlidableAction(
                  onPressed: (ctx) => onTransactionEdited(transaction.id),
                  icon: Icons.edit,
                  backgroundColor: theme.colorScheme.secondary.withAlpha(220),
                  label: 'Edit',
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            child: TransactionCard(transaction: transaction),
          );
        },
      ),
    );
  }
}
