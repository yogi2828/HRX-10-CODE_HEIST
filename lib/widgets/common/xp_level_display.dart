// lib/widgets/common/xp_level_display.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class XpLevelDisplay extends StatelessWidget {
  final int xp;
  final int level;
  final int currentStreak;

  const XpLevelDisplay({
    super.key,
    required this.xp,
    required this.level,
    required this.currentStreak,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding / 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing, vertical: AppConstants.spacing / 2),
            decoration: BoxDecoration(
              color: AppColors.levelColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              border: Border.all(color: AppColors.levelColor),
            ),
            child: Text(
              'LVL $level',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.levelColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.spacing),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing, vertical: AppConstants.spacing / 2),
            decoration: BoxDecoration(
              color: AppColors.xpColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              border: Border.all(color: AppColors.xpColor),
            ),
            child: Text(
              '$xp XP',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.xpColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.spacing),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing, vertical: AppConstants.spacing / 2),
            decoration: BoxDecoration(
              color: AppColors.streakColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              border: Border.all(color: AppColors.streakColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_fire_department, color: AppColors.streakColor, size: AppConstants.iconSize * 0.7),
                Text(
                  '$currentStreak',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.streakColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
