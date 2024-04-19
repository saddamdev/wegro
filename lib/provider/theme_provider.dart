import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData theme = ThemeData(primarySwatch: Colors.green);

  void toggleTheme() {
    final isDark = theme == ThemeData.dark();

    isDark
        ? theme = ThemeData(primarySwatch: Colors.green)
        : theme = ThemeData.dark();

    notifyListeners();
  }
}
