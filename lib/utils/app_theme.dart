import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryDark = Color(0xFF0F172A);
  static const Color cardBg = Color(0xFF1E293B);
  static const Color accentOrange = Color(0xFFF97316);
  static const Color warningYellow = Color(0xFFEAB308);
  static const Color successGreen = Color(0xFF22C55E);
  static const Color dangerRed = Color(0xFFEF4444);
  static const Color textLight = Color(0xFFF8FAFC);
  static const Color textMuted = Color(0xFF94A3B8);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryDark,
      primaryColor: accentOrange,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textLight),
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentOrange, width: 2),
        ),
        labelStyle: const TextStyle(color: textMuted),
        hintStyle: const TextStyle(color: textMuted),
      ),
    );
  }
}