import 'package:flutter/material.dart';
import 'package:personal_finance/data/categories_data.dart';
import 'package:personal_finance/helpers/format_datetime.dart';
import 'package:personal_finance/models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final void Function(Transaction newTransaction) onTransactionSaved;
  final Transaction? existingTransaction;
  const TransactionForm({
    super.key,
    required this.onTransactionSaved,
    this.existingTransaction,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  var selectedDate = DateTime.now();
  var selectedTimeOfDay = TimeOfDay.now();
  String? selectedCategory;

  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.existingTransaction != null) {
      final existingTransaction = widget.existingTransaction!;
      titleController.text = existingTransaction.title;
      amountController.text = existingTransaction.amount.toString();
      selectedDate = existingTransaction.dateTime;
      selectedTimeOfDay = TimeOfDay.fromDateTime(selectedDate);
      selectedCategory = existingTransaction.categoryId;
    }

    dateController.text = formatDate(selectedDate);
    timeController.text = formatTime(selectedTimeOfDay);
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  bool isTransactionInvalid() {
    final parsedAmount = double.tryParse(amountController.text);
    final amountIsInvalid = parsedAmount == null || parsedAmount <= 0;
    return titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedCategory == null;
  }

  void onCanceled() {
    Navigator.pop(context);
  }

  void onSaved() {
    if (isTransactionInvalid()) {
      return;
    }

    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTimeOfDay.hour,
      selectedTimeOfDay.minute,
    );
    final newTransaction = Transaction(
      id: widget.existingTransaction?.id,
      title: titleController.text.trim(),
      amount: double.parse(amountController.text),
      dateTime: dateTime,
      categoryId: selectedCategory!,
    );
    widget.onTransactionSaved(newTransaction);
    Navigator.pop(context);
  }

  void onDateTap() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final dateFromUser = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: selectedDate,
    );

    if (dateFromUser != null) {
      setState(() {
        selectedDate = dateFromUser;
        dateController.text = formatDate(dateFromUser);
      });
    }
  }

  void onTimeTap() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTimeOfDay,
    );

    if (pickedTime != null) {
      setState(() {
        selectedTimeOfDay = pickedTime;
        timeController.text = formatTime(pickedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 24, 24, bottomInset + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onTap: onDateTap,
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(label: Text('Date')),
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 100,
                  child: TextField(
                    onTap: onTimeTap,
                    readOnly: true,
                    controller: timeController,
                    decoration: InputDecoration(label: Text('Time')),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      label: Text('Amount'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              label: Text('Category'),
              inputDecorationTheme: theme.inputDecorationTheme,
              initialSelection: selectedCategory,
              onSelected: (value) => setState(() => selectedCategory = value),
              dropdownMenuEntries: categories
                  .map((category) => DropdownMenuEntry(
                        value: category.id,
                        leadingIcon: Icon(category.icon),
                        label: category.title,
                      ))
                  .toList(),
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
                    onPressed: isTransactionInvalid() ? null : onSaved,
                    child: Text('Save'),
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
