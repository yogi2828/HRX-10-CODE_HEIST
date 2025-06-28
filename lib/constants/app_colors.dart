// lib/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF1A1A2E);
  static const Color accentColor = Color(0xFFE94560);
  static const Color secondaryColor = Color(0xFF0F3460);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textColorSecondary = Color(0xFFAAAAAA);

  static const Color xpColor = Color(0xFFFDCB6E);
  static const Color levelColor = Color(0xFF00B894);
  static const Color streakColor = Color(0xFFEB2F96);

  static const Color successColor = Color(0xFF28A745);
  static const Color errorColor = Color(0xFFDC3545);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF17A2B8);

  static const Color cardColor = Color(0xFF2E2E4A);
  static const Color borderColor = Color(0xFF3F3F60);
  static const Color transparent = Colors.transparent;

  static LinearGradient backgroundGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor,
        secondaryColor,
      ],
    );
  }

  static LinearGradient buttonGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        accentColor,
        Color(0xFFCE203A),
      ],
    );
  }
}
