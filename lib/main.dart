import 'package:flutter/material.dart';
import 'package:personal_finance/personal_finance.dart';
import 'package:personal_finance/theme/dark_theme.dart';
import 'package:personal_finance/theme/light_theme.dart';

void main() {
  runApp(MaterialApp(
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: ThemeMode.system,
    home: PersonalFinance(),
  ));
}
