import 'package:flutter/material.dart';
import 'package:personal_finance/screens/transactions_screen.dart';

class PersonalFinance extends StatefulWidget {
  const PersonalFinance({super.key});

  @override
  State<PersonalFinance> createState() => _PersonalFinanceState();
}

class _PersonalFinanceState extends State<PersonalFinance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: TransactionsScreen(),
    );
  }
}
