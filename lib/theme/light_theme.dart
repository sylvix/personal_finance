import 'package:flutter/material.dart';
import 'package:personal_finance/theme/colors.dart';

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
);

final lightCustomColors = CustomColors(
  expense: Colors.red.shade700,
  chartBadgeShadow: Colors.grey.withAlpha(128),
);

final lightTheme = ThemeData.light().copyWith(
  colorScheme: lightColorScheme,
  extensions: [lightCustomColors],
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: lightColorScheme.onPrimaryContainer,
    foregroundColor: lightColorScheme.primaryContainer,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.onPrimaryContainer,
      foregroundColor: lightColorScheme.primaryContainer,
    ),
  ),
);
