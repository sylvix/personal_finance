import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color expense;
  final Color chartBadgeShadow;

  CustomColors({
    required this.expense,
    required this.chartBadgeShadow,
  });

  @override
  ThemeExtension<CustomColors> copyWith({
    Color? expense,
    Color? chartBadgeShadow,
  }) {
    return CustomColors(
      expense: expense ?? this.expense,
      chartBadgeShadow: chartBadgeShadow ?? this.chartBadgeShadow,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(
      ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;

    return CustomColors(
      expense: Color.lerp(expense, other.expense, t)!,
      chartBadgeShadow:
          Color.lerp(chartBadgeShadow, other.chartBadgeShadow, t)!,
    );
  }
}
