import 'package:flutter/material.dart';
import 'package:personal_finance/models/transaction.dart';
import 'package:personal_finance/screens/transactions_screen.dart';
import 'package:personal_finance/widgets/transaction_form.dart';

import 'data/transactions_data.dart';

class PersonalFinance extends StatefulWidget {
  const PersonalFinance({super.key});

  @override
  State<PersonalFinance> createState() => _PersonalFinanceState();
}

class _PersonalFinanceState extends State<PersonalFinance> {
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final loadedTransactions = await loadTransactions();
    setState(() {
      transactions = loadedTransactions;
    });
  }

  void addTransaction(Transaction newTransaction) {
    setState(() {
      transactions.add(newTransaction);
    });
    saveTransactions(transactions);
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((transaction) => transaction.id == id);
    });
    saveTransactions(transactions);
  }

  void editTransaction(Transaction editedTransaction) {
    setState(() {
      final index = transactions
          .indexWhere((transaction) => transaction.id == editedTransaction.id);
      transactions[index] = editedTransaction;
    });
    saveTransactions(transactions);
  }

  void openAddTransactionSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => TransactionForm(
        onTransactionSaved: addTransaction,
      ),
    );
  }

  void openEditTransactionSheet(String id) {
    final existingTransaction =
        transactions.firstWhere((transaction) => transaction.id == id);
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => TransactionForm(
        onTransactionSaved: editTransaction,
        existingTransaction: existingTransaction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
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
      body: TransactionsScreen(
        transactions: transactions,
        onTransactionDeleted: deleteTransaction,
        onTransactionEdited: openEditTransactionSheet,
      ),
    );
  }
}
