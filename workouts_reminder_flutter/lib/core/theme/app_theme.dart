import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData _baseTheme() {
    final ThemeData theme = ThemeData.light();
    return theme.copyWith(
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  static ThemeData get lightTheme => _baseTheme().copyWith();

  static ThemeData get darkTheme => _baseTheme().copyWith();
}
