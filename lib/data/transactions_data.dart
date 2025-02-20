import 'dart:io';
import 'dart:convert';

import 'package:personal_finance/helpers/get_data_file_path.dart';
import 'package:personal_finance/models/transaction.dart';

Future<void> saveTransactions(List<Transaction> transactions) async {
  final filePath = await getDataFilePath('transactions');
  final file = File(filePath);
  final transactionMaps = transactions
      .map((transaction) => {
            'id': transaction.id,
            'title': transaction.title,
            'amount': transaction.amount,
            'dateTime': transaction.dateTime.toIso8601String(),
            'categoryId': transaction.categoryId,
          })
      .toList();
  final transactionsJson = jsonEncode(transactionMaps);

  await file.writeAsString(transactionsJson);
}

Future<List<Transaction>> loadTransactions() async {
  try {
    final filePath = await getDataFilePath('transactions');
    final file = File(filePath);
    final jsonContents = await file.readAsString();
    final transactionMaps = jsonDecode(jsonContents) as List<dynamic>;

    return transactionMaps.map((transactionMap) {
      return Transaction(
        id: transactionMap['id'],
        title: transactionMap['title'],
        amount: transactionMap['amount'],
        dateTime: DateTime.parse(transactionMap['dateTime']),
        categoryId: transactionMap['categoryId'],
      );
    }).toList();
  } catch (error) {
    return [];
  }
}
