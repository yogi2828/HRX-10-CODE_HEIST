// lib/widgets/gamification/level_up_animation.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:lottie/lottie.dart';

class LevelUpAnimation extends StatelessWidget {
  final int newLevel;
  final VoidCallback onAnimationComplete;

  const LevelUpAnimation({
    super.key,
    required this.newLevel,
    required this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.transparent, // Background will be covered by the modal or dialog
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/levelup.json', // Your level up animation
              width: 300,
              height: 300,
              repeat: false,
              onLoaded: (composition) {
                Future.delayed(composition.duration, onAnimationComplete);
              },
              errorBuilder: (context, error, stackTrace) => Column(
                children: [
                  const Icon(
                    Icons.star,
                    size: 150,
                    color: AppColors.levelColor,
                  ),
                  const SizedBox(height: AppConstants.padding),
                  Text(
                    'LEVEL UP!',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.levelColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.padding),
            Text(
              'You reached Level $newLevel!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
