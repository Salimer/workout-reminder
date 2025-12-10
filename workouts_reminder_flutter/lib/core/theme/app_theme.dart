import 'package:flutter/material.dart';

class AppTheme {
  // Core greens for brand consistency.
  static const Color _green900 = Color(0xFF0C1F17);
  static const Color _green700 = Color(0xFF0F3526);
  static const Color _green500 = Color(0xFF1DBA74);
  static const Color _green300 = Color(0xFF6EE7B7);
  static const Color _green100 = Color(0xFFA7F3D0);

  static ColorScheme _darkScheme() {
    final base = ColorScheme.fromSeed(
      seedColor: _green500,
      brightness: Brightness.dark,
    );
    return base.copyWith(
      primary: _green500,
      onPrimary: Colors.black,
      secondary: _green300,
      onSecondary: Colors.black,
      surface: _green700,
      onSurface: Colors.white70,
      surfaceTint: _green500,
      error: Colors.redAccent.shade100,
      onError: Colors.black,
    );
  }

  static ColorScheme _lightScheme() {
    final base = ColorScheme.fromSeed(
      seedColor: _green500,
      brightness: Brightness.light,
    );
    return base.copyWith(
      primary: _green500,
      onPrimary: Colors.white,
      secondary: _green300,
      onSecondary: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black87,
      surfaceTint: _green500,
      error: Colors.red.shade700,
      onError: Colors.white,
    );
  }

  static ThemeData _buildTheme(ColorScheme scheme) {
    final Color scaffoldBackground =
        scheme.brightness == Brightness.dark ? _green900 : const Color(0xFFF7F9F7);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        elevation: 0,
        foregroundColor: scheme.onSurface,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(fontWeight: FontWeight.w500),
      ).apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scheme.surface,
        elevation: 0,
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.onSurface.withValues(alpha: 0.6),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      cardColor: scheme.surface,
      dividerColor: scheme.onSurface.withValues(alpha: 0.12),
    );
  }

  static ThemeData get darkTheme => _buildTheme(_darkScheme());
  static ThemeData get lightTheme => _buildTheme(_lightScheme());
}
