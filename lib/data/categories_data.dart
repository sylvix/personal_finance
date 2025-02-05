import 'package:flutter/material.dart';
import 'package:personal_finance/models/transaction_category.dart';

final categories = [
  TransactionCategory(
    id: 'food_and_drinks',
    title: 'Food and Drinks',
    icon: Icons.restaurant,
  ),
  TransactionCategory(
    id: 'entertainment',
    title: 'Entertainment',
    icon: Icons.theater_comedy_outlined,
  ),
  TransactionCategory(
    id: 'transport',
    title: 'Transportation',
    icon: Icons.commute,
  ),
  TransactionCategory(
    id: 'home',
    title: 'Home',
    icon: Icons.home,
  ),
];
