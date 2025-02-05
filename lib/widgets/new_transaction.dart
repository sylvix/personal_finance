import 'package:flutter/material.dart';
import 'package:personal_finance/data/categories_data.dart';
import 'package:personal_finance/helpers/format_datetime.dart';
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
  var selectedDate = DateTime.now();
  var selectedTimeOfDay = TimeOfDay.now();
  String? selectedCategory;

  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = formatDate(selectedDate);
    timeController.text = formatTime(selectedTimeOfDay);
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  bool isTransactionInvalid() {
    final parsedAmount = double.tryParse(amount);
    final amountIsInvalid = parsedAmount == null || parsedAmount <= 0;
    return title.trim().isEmpty || amountIsInvalid || selectedCategory == null;
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
      title: title.trim(),
      amount: double.parse(amount),
      dateTime: dateTime,
      categoryId: selectedCategory!,
    );
    widget.onTransactionCreated(newTransaction);
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
