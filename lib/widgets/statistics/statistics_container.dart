import 'package:flutter/material.dart';

class StatisticsContainer extends StatelessWidget {
  final Widget child;
  const StatisticsContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
