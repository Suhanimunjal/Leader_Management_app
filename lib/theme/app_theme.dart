import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primary = Color(0xFF0A6CF5); // professional blue
  static const Color _accent = Color(0xFF00C2A8); // teal accent
  static const Color _surface = Color(0xFFF7F9FC);
  static const Color _card = Colors.white;

  static ThemeData get light {
    final base = ThemeData.light();
    return base.copyWith(
      // Keep density and app bar sizing consistent between themes to avoid
      // unexpected layout differences when switching modes.
      visualDensity: VisualDensity.standard,
      colorScheme: base.colorScheme.copyWith(
        primary: _primary,
        secondary: _accent,
        background: _surface,
        surface: _card,
      ),
      primaryColor: _primary,
      scaffoldBackgroundColor: _surface,
      appBarTheme: const AppBarTheme(
        elevation: 0.5,
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        toolbarHeight: kToolbarHeight,
      ),
      cardColor: _card,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: _primary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      textTheme: base.textTheme.copyWith(
        titleLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        bodyMedium: const TextStyle(fontSize: 15),
        bodySmall: const TextStyle(fontSize: 13, color: Colors.black54),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _accent,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData get dark {
    final base = ThemeData.dark();
    return base.copyWith(
      visualDensity: VisualDensity.standard,
      colorScheme: base.colorScheme.copyWith(
        primary: _primary,
        secondary: _accent,
      ),
      primaryColor: _primary,
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        elevation: 0.5,
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        toolbarHeight: kToolbarHeight,
      ),
      cardColor: Colors.grey[850],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[800],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      textTheme: base.textTheme.copyWith(
        titleLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        bodyMedium: const TextStyle(fontSize: 15),
        bodySmall: const TextStyle(fontSize: 13, color: Colors.white70),
      ),
    );
  }
}
