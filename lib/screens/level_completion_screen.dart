// lib/screens/level_completion_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:gamifier/utils/app_router.dart'; // New import

class LevelCompletionScreen extends StatelessWidget {
  final String levelTitle;
  final int xpEarned;
  final int newLevel;

  const LevelCompletionScreen({
    super.key,
    required this.levelTitle,
    required this.xpEarned,
    required this.newLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: const CustomAppBar(title: 'Level Up!'),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/levelup.json', // Placeholder for a level-up animation
                  width: 200,
                  height: 200,
                  repeat: false,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.star,
                    size: 150,
                    color: AppColors.levelColor,
                  ),
                ),
                const SizedBox(height: AppConstants.padding * 2),
                Text(
                  'Level Complete!',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.levelColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.spacing),
                Text(
                  'You\'ve mastered "$levelTitle" and reached:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.spacing),
                Text(
                  'Level $newLevel!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.padding * 2),
                Card(
                  color: AppColors.cardColor,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding * 1.5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: AppColors.xpColor, size: AppConstants.iconSize * 1.5),
                            const SizedBox(width: AppConstants.spacing),
                            Text(
                              'XP Earned: $xpEarned',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.xpColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.padding * 2),
                ElevatedButton.icon(
                  onPressed: () {
                    // Pop this screen and potentially others until back to level selection or home
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.homeRoute, (route) => false);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Continue Learning'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
                    textStyle: const TextStyle(fontSize: AppConstants.largeTextSize),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
