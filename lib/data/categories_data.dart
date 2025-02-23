import 'package:flutter/material.dart';
import 'package:personal_finance/models/transaction_category.dart';

final categories = [
  TransactionCategory(
    id: 'food_and_drinks',
    title: 'Food and Drinks',
    icon: Icons.restaurant,
    color: Colors.green.shade700,
  ),
  TransactionCategory(
    id: 'entertainment',
    title: 'Entertainment',
    icon: Icons.theater_comedy_outlined,
    color: Colors.red.shade700,
  ),
  TransactionCategory(
    id: 'transport',
    title: 'Transportation',
    icon: Icons.commute,
    color: Colors.indigo.shade400,
  ),
  TransactionCategory(
    id: 'home',
    title: 'Home',
    icon: Icons.home,
    color: Colors.amber.shade700,
  ),
];
