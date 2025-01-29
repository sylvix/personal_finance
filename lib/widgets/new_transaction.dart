import 'package:flutter/material.dart';
import 'package:personal_finance/models/transaction.dart';

class NewTransaction extends StatefulWidget {
  final void Function(Transaction newTransaction) onTransactionCreated;
  const NewTransaction({super.key, required this.onTransactionCreated});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  var title = '';
  var amount = '';

  void onCanceled() {
    Navigator.pop(context);
  }

  void onSaved() {
    final newTransaction =
        Transaction(title: title, amount: double.parse(amount));
    widget.onTransactionCreated(newTransaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print('title: $title, amount: $amount');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => setState(() => title = value),
                  decoration: InputDecoration(
                    label: Text('Title'),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  onChanged: (value) => setState(() => amount = value),
                  decoration: InputDecoration(
                    label: Text('Amount'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onCanceled,
                  child: Text('Cancel'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onSaved,
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
