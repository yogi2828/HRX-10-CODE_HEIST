// lib/widgets/gamification/streak_display.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class StreakDisplay extends StatelessWidget {
  final int currentStreak;

  const StreakDisplay({
    super.key,
    required this.currentStreak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
      decoration: BoxDecoration(
        color: AppColors.streakColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.streakColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.streakColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department,
            color: AppColors.streakColor,
            size: AppConstants.iconSize + 8,
          ),
          const SizedBox(width: AppConstants.spacing),
          Text(
            '$currentStreak-Day Streak!',
            style: const TextStyle(
              color: AppColors.streakColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (currentStreak >= AppConstants.minStreakDaysForBonus) ...[
            const SizedBox(width: AppConstants.spacing),
            const Tooltip(
              message: 'XP Bonus for maintaining streak!',
              child: Icon(Icons.star, color: AppColors.xpColor, size: AppConstants.iconSize),
            ),
          ],
        ],
      ),
    );
  }
}