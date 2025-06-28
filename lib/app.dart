// lib/app.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/services/audio_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AudioService>(context, listen: false).loadAudioAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
        hintColor: AppColors.accentColor,
        scaffoldBackgroundColor: Colors.transparent,
        cardColor: AppColors.cardColor,
        fontFamily: AppConstants.defaultFontFamily,
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.textColor),
          displayMedium: TextStyle(color: AppColors.textColor),
          displaySmall: TextStyle(color: AppColors.textColor),
          headlineLarge: TextStyle(color: AppColors.textColor),
          headlineMedium: TextStyle(color: AppColors.textColor),
          headlineSmall: TextStyle(color: AppColors.textColor),
          titleLarge: TextStyle(color: AppColors.textColor),
          titleMedium: TextStyle(color: AppColors.textColor),
          titleSmall: TextStyle(color: AppColors.textColor),
          bodyLarge: TextStyle(color: AppColors.textColor),
          bodyMedium: TextStyle(color: AppColors.textColor),
          bodySmall: TextStyle(color: AppColors.textColor),
          labelLarge: TextStyle(color: AppColors.textColor),
          labelMedium: TextStyle(color: AppColors.textColor),
          labelSmall: TextStyle(color: AppColors.textColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.cardColor.withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: const BorderSide(color: AppColors.borderColor, width: 1.0),
          ),
          labelStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.8)),
          hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.5)),
          prefixIconColor: AppColors.textColorSecondary,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accentColor,
            textStyle: const TextStyle(fontSize: 14),
          ),
        ),
        cardTheme: CardTheme(
          color: AppColors.cardColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.accentColor,
          unselectedLabelColor: AppColors.textColorSecondary,
          indicator: UnderlineTabIndicator(
            borderSide: const BorderSide(color: AppColors.accentColor, width: 3.0),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
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
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splashRoute,
    );
  }
}