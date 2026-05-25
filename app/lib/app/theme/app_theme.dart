import 'package:flutter/material.dart';

class AppTheme {
  static const magentaPrimary = Color(0xFFD81B9A);
  static const magentaDark = Color(0xFFAD1457);
  static const magentaLight = Color(0xFFF8BBD0);
  static const whitePure = Color(0xFFFFFFFF);
  static const whiteSmoke = Color(0xFFFAFAFA);
  static const darkText = Color(0xFF1A1A2E);
  static const grayText = Color(0xFF6B7280);
  static const grayLight = Color(0xFFE5E7EB);

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: magentaPrimary,
      brightness: Brightness.light,
      primary: magentaPrimary,
      secondary: magentaDark,
      surface: whitePure,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: whiteSmoke,
      appBarTheme: const AppBarTheme(
        backgroundColor: magentaPrimary,
        foregroundColor: whitePure,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: whitePure,
        surfaceTintColor: whitePure,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: whiteSmoke,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: grayLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: grayLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: magentaPrimary, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: magentaPrimary,
          foregroundColor: whitePure,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: darkText),
        bodySmall: TextStyle(color: grayText),
        titleMedium: TextStyle(color: darkText, fontWeight: FontWeight.w600),
      ),
      dividerTheme: const DividerThemeData(color: grayLight, thickness: 1),
      useMaterial3: true,
    );
  }
}
