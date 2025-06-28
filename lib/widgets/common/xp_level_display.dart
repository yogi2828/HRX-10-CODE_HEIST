// lib/widgets/common/xp_level_display.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/widgets/common/progress_bar.dart';

class XpLevelDisplay extends StatelessWidget {
  final int xp;
  final int level;

  const XpLevelDisplay({
    super.key,
    required this.xp,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final int xpForCurrentLevel = (level - 1) * AppConstants.xpPerLevel;
    final int xpProgressInCurrentLevel = xp - xpForCurrentLevel;
    final int xpNeededForNextLevel = AppConstants.xpPerLevel;

    double progress = xpNeededForNextLevel > 0
        ? xpProgressInCurrentLevel / xpNeededForNextLevel
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Level $level',
              style: const TextStyle(
                color: AppColors.levelColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$xp XP',
              style: const TextStyle(
                color: AppColors.xpColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacing),
        ProgressBar(
          current: xpProgressInCurrentLevel,
          total: xpNeededForNextLevel,
          backgroundColor: AppColors.progressTrackColor,
          progressColor: AppColors.xpColor,
        ),
        const SizedBox(height: AppConstants.spacing / 2),
        Text(
          '${xpProgressInCurrentLevel} / $xpNeededForNextLevel XP to next level',
          style: const TextStyle(
            color: AppColors.textColorSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}