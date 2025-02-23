import 'package:flutter/material.dart';

class TransactionCategory {
  final String id;
  final String title;
  final IconData icon;
  final Color color;

  TransactionCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
  });
}
