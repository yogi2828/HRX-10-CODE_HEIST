// lib/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF6A1B9A);
  static const Color primaryColorDark = Color(0xFF4A148C);
  static const Color accentColor = Color(0xFF00E5FF);
  static const Color secondaryColor = Color(0xFFE040FB);
  static const Color textColor = Color(0xFFE0E0E0);
  static const Color textColorSecondary = Color(0xFFB0BEC5);
  static const Color cardColor = Color(0xFF2C2C2C);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color borderColor = Color(0xFF424242);
  static const Color successColor = Color(0xFF00C853);
  static const Color errorColor = Color(0xFFD50000);
  static const Color warningColor = Color(0xFFFFC400);
  static const Color infoColor = Color(0xFF2196F3);
  static const Color xpColor = Color(0xFFFDD835);
  static const Color levelColor = Color(0xFF8BC34A);
  static const Color streakColor = Color(0xFFFD8C00);
  static const Color progressTrackColor = Color(0xFF37474F);

  static LinearGradient backgroundGradient() {
    return const LinearGradient(
      colors: [
        backgroundColor,
        Color(0xFF1A237E),
        primaryColorDark,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static TextStyle neonTextStyle({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.bold,
    Color color = accentColor,
    double blurRadius = 0.5,
    double spreadRadius = 0.0,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      shadows: [
        Shadow(
          color: color.withOpacity(0.8),
          blurRadius: blurRadius,
        ),
        Shadow(
          color: color.withOpacity(0.4),
          blurRadius: blurRadius * 2,
        ),
      ],
    );
  }
}