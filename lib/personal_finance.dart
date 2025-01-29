import 'package:flutter/material.dart';
import 'package:personal_finance/models/transaction.dart';
import 'package:personal_finance/screens/transactions_screen.dart';
import 'package:personal_finance/widgets/new_transaction.dart';

class PersonalFinance extends StatefulWidget {
  const PersonalFinance({super.key});

  @override
  State<PersonalFinance> createState() => _PersonalFinanceState();
}

class _PersonalFinanceState extends State<PersonalFinance> {
  List<Transaction> transactions = [
    Transaction(title: 'Coffee', amount: 150),
    Transaction(title: 'Groceries', amount: 500),
    Transaction(title: 'Cinema', amount: 600),
    Transaction(title: 'Bus fare', amount: 20),
    Transaction(title: 'Water bill', amount: 300),
  ];

  void addTransaction(Transaction newTransaction) {
    setState(() {
      transactions.add(newTransaction);
    });
  }

  void openAddTransactionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTransaction(
        onTransactionCreated: addTransaction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        actions: [
          IconButton(
            onPressed: openAddTransactionSheet,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: TransactionsScreen(transactions: transactions),
    );
  }
}
