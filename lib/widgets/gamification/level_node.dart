// lib/widgets/gamification/level_node.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/level.dart';

class LevelNode extends StatelessWidget {
  final Level level;
  final bool isCompleted;
  final bool isLocked;
  final VoidCallback onTap;

  const LevelNode({
    super.key,
    required this.level,
    required this.isCompleted,
    required this.isLocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color nodeColor = AppColors.cardColor;
    Color iconColor = AppColors.textColorSecondary;
    Color borderColor = AppColors.borderColor;
    IconData icon = Icons.lock;

    if (isCompleted) {
      nodeColor = AppColors.successColor.withOpacity(0.3);
      iconColor = AppColors.successColor;
      borderColor = AppColors.successColor;
      icon = Icons.check_circle_outline;
    } else if (!isLocked) {
      nodeColor = AppColors.accentColor.withOpacity(0.3);
      iconColor = AppColors.accentColor;
      borderColor = AppColors.accentColor;
      icon = Icons.play_circle_outline;
    }

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: AnimatedContainer(
        duration: AppConstants.defaultAnimationDuration,
        curve: Curves.easeInOut,
        width: 120, // Fixed width for circular node
        height: 120, // Fixed height for circular node
        decoration: BoxDecoration(
          color: nodeColor,
          shape: BoxShape.circle, // Make it circular
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: isCompleted ? 3 : 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 40, // Adjusted icon size for circular node
            ),
            const SizedBox(height: AppConstants.spacing / 2),
            Text(
              'Level ${level.order}',
              style: TextStyle(
                color: iconColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing),
              child: Text(
                level.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textColorSecondary,
                  fontSize: 10, // Adjusted font size
                ),
              ),
            ),
            if (isLocked)
              const Padding(
                padding: EdgeInsets.only(top: AppConstants.spacing / 2),
                child: Text(
                  'Locked',
                  style: TextStyle(
                    color: AppColors.errorColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}