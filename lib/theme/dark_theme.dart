import 'package:flutter/material.dart';
import 'package:personal_finance/theme/colors.dart';

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  brightness: Brightness.dark,
);

final darkCustomColors = CustomColors(
  expense: Colors.red,
  chartBadgeShadow: Colors.white,
);

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: darkColorScheme,
  extensions: [darkCustomColors],
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkColorScheme.onPrimaryContainer,
      foregroundColor: darkColorScheme.primaryContainer,
    ),
  ),
);
