// gamifier/lib/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF6A1B9A); // Deep Purple
  static const Color primaryColorDark = Color(0xFF4A148C); // Darker Purple
  static const Color accentColor = Color(0xFF00E5FF); // Cyan/Aqua for highlights
  static const Color secondaryColor = Color(0xFFE040FB); // Bright Pink/Magenta
  static const Color textColor = Color(0xFFE0E0E0); // Light Gray
  static const Color textColorSecondary = Color(0xFFB0BEC5); // Muted Blue-Gray
  static const Color cardColor = Color(0xFF2C2C2C); // Dark Gray for cards
  static const Color backgroundColor = Color(0xFF121212); // Very Dark Gray/Black for background
  static const Color borderColor = Color(0xFF424242); // Slightly lighter border for subtle depth
  static const Color successColor = Color(0xFF00C853); // Green for success
  static const Color errorColor = Color(0xFFD50000); // Red for errors
  static const Color warningColor = Color(0xFFFFC400); // Amber for warnings
  static const Color infoColor = Color(0xFF2196F3); // Blue for info
  static const Color xpColor = Color(0xFFFDD835); // Yellow for XP
  static const Color levelColor = Color(0xFF8BC34A); // Light Green for levels
  static const Color streakColor = Color(0xFFFD8C00); // Orange for streaks
  static const Color progressTrackColor = Color(0xFF37474F); // Dark blue-gray for progress bar track

  // Background Gradient for general screens
  static LinearGradient backgroundGradient() {
    return const LinearGradient(
      colors: [
        Color(0xFF000000), // Start with black for deep space
        Color(0xFF1A237E), // Transition to a deep indigo
        primaryColorDark, // End with a dark purple
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // Gradient for buttons and highlighted elements
  static LinearGradient buttonGradient() {
    return const LinearGradient(
      colors: [
        primaryColor,
        secondaryColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // Neon text style with glow effect
  static TextStyle neonTextStyle({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.bold,
    Color color = accentColor,
    double blurRadius = 15.0,
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








