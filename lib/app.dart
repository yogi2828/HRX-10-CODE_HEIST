// gamifier/lib/app.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/services/audio_service.dart';
import 'package:gamifier/widgets/common/animated_background.dart'; // Import the animated background

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
      // For web, ensure the title appears in the browser tab
      builder: (context, child) {
        return AnimatedBackground(
          child: child!, // Wrap the entire app content with the animated background
        );
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
        hintColor: AppColors.accentColor,
        scaffoldBackgroundColor: Colors.transparent, // Make scaffold transparent to show background
        cardColor: AppColors.cardColor,
        fontFamily: AppConstants.defaultFontFamily,
        textTheme: const TextTheme(
          // Ensure all text styles use the base textColor
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Adjusted padding
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Larger text
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accentColor,
            textStyle: const TextStyle(fontSize: 16), // Larger text
          ),
        ),
        cardTheme: CardTheme(
          color: AppColors.cardColor,
          elevation: 8, // Increased elevation for depth
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.accentColor,
          unselectedLabelColor: AppColors.textColorSecondary,
          indicator: UnderlineTabIndicator(
            borderSide: const BorderSide(color: AppColors.accentColor, width: 4.0), // Thicker indicator
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          titleTextStyle: const TextStyle(color: AppColors.textColor, fontSize: 22, fontWeight: FontWeight.bold), // Larger text
          contentTextStyle: const TextStyle(color: AppColors.textColorSecondary, fontSize: 18), // Larger text
        ),
        // No BottomNavigationBarTheme as it will be replaced by a Top Navigation Bar
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splashRoute,
    );
  }
}