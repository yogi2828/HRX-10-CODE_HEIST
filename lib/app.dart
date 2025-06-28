// lib/app.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
        hintColor: AppColors.accentColor,
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: AppConstants.defaultFontFamily,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57, color: AppColors.textColor),
          displayMedium: TextStyle(fontSize: 45, color: AppColors.textColor),
          displaySmall: TextStyle(fontSize: 36, color: AppColors.textColor),
          headlineLarge: TextStyle(fontSize: 32, color: AppColors.textColor),
          headlineMedium: TextStyle(fontSize: 28, color: AppColors.textColor),
          headlineSmall: TextStyle(fontSize: 24, color: AppColors.textColor),
          titleLarge: TextStyle(fontSize: 22, color: AppColors.textColor),
          titleMedium: TextStyle(fontSize: 16, color: AppColors.textColor),
          titleSmall: TextStyle(fontSize: 14, color: AppColors.textColor),
          bodyLarge: TextStyle(fontSize: 16, color: AppColors.textColor),
          bodyMedium: TextStyle(fontSize: 14, color: AppColors.textColor),
          bodySmall: TextStyle(fontSize: 12, color: AppColors.textColor),
          labelLarge: TextStyle(fontSize: 14, color: AppColors.textColor),
          labelMedium: TextStyle(fontSize: 12, color: AppColors.textColor),
          labelSmall: TextStyle(fontSize: 11, color: AppColors.textColor),
        ),
        cardTheme: CardTheme(
          color: AppColors.cardColor.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          elevation: 8,
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: AppColors.textColorSecondary),
          hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.7)),
          fillColor: AppColors.cardColor.withOpacity(0.8),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: const BorderSide(color: AppColors.accentColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: const BorderSide(color: AppColors.errorColor, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing * 1.5),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accentColor,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.accentColor,
            side: const BorderSide(color: AppColors.accentColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing * 1.5),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          titleTextStyle: const TextStyle(color: AppColors.textColor, fontSize: 20, fontWeight: FontWeight.bold),
          contentTextStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          backgroundColor: AppColors.primaryColor,
          contentTextStyle: const TextStyle(color: AppColors.textColor),
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splashRoute,
    );
  }
}
