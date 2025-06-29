
// gamifier/lib/widgets/common/xp_level_display.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_profile.dart'; // Ensure this model is defined

class XpLevelDisplay extends StatelessWidget {
  final UserProfile userProfile;

  const XpLevelDisplay({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // XP Display
          Row(
            children: [
              Icon(Icons.star_rounded, color: AppColors.xpColor, size: AppConstants.iconSize * 0.8),
              const SizedBox(width: 4),
              Text(
                'XP: ${userProfile.xp}',
                style: TextStyle(
                  color: AppColors.xpColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppConstants.spacing),
          // Level Display
          Row(
            children: [
              Icon(Icons.trending_up_rounded, color: AppColors.levelColor, size: AppConstants.iconSize * 0.8),
              const SizedBox(width: 4),
              Text(
                'Lvl: ${userProfile.level}',
                style: TextStyle(
                  color: AppColors.levelColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}