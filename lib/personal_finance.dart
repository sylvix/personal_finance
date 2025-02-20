import 'package:flutter/material.dart';
import 'package:personal_finance/models/destination.dart';
import 'package:personal_finance/models/transaction.dart';
import 'package:personal_finance/screens/statistics_screen.dart';
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
  int currentScreenIndex = 0;

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

  void updateCurrentPageIndex(int newIndex) {
    setState(() {
      currentScreenIndex = newIndex;
    });
  }

  List<Destination> get destinations {
    return [
      Destination(
        screenTitle: Text('Transactions'),
        navLabel: 'Transactions',
        navIcon: Icons.receipt_long_outlined,
        navSelectedIcon: Icons.receipt_long,
        appBarActions: [
          IconButton(
            onPressed: openAddTransactionSheet,
            icon: Icon(Icons.add),
          ),
        ],
        screen: TransactionsScreen(
          transactions: transactions,
          onTransactionDeleted: deleteTransaction,
          onTransactionEdited: openEditTransactionSheet,
        ),
      ),
      Destination(
        screenTitle: Text('Statistics'),
        navLabel: 'Statistics',
        navIcon: Icons.pie_chart_outline,
        navSelectedIcon: Icons.pie_chart,
        screen: StatisticsScreen(
          transactions: transactions,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    final destination = destinations[currentScreenIndex];

    return Scaffold(
      appBar: AppBar(
        title: destination.screenTitle,
        actions: destination.appBarActions,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreenIndex,
        onDestinationSelected: updateCurrentPageIndex,
        destinations: destinations
            .map((destination) => NavigationDestination(
                icon: Icon(destination.navIcon),
                selectedIcon: Icon(destination.navSelectedIcon),
                label: destination.navLabel))
            .toList(),
      ),
      body: destination.screen,
    );
  }
}
