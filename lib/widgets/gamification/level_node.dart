// lib/widgets/gamification/level_node.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/level.dart';

class LevelNode extends StatelessWidget {
  final Level level;
  final bool isLocked;
  final bool isCompleted;
  final VoidCallback onTap;

  const LevelNode({
    super.key,
    required this.level,
    required this.isLocked,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color nodeColor = AppColors.primaryColor;
    Color iconColor = AppColors.textColor;
    Color textColor = AppColors.textColor;
    IconData icon = Icons.lock; // Default for locked

    if (!isLocked) {
      if (isCompleted) {
        nodeColor = AppColors.successColor;
        iconColor = AppColors.cardColor;
        textColor = AppColors.cardColor;
        icon = Icons.check_circle;
      } else {
        nodeColor = AppColors.accentColor;
        iconColor = AppColors.cardColor;
        textColor = AppColors.cardColor;
        icon = Icons.play_arrow;
      }
    }

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: nodeColor,
              border: Border.all(
                color: isLocked ? AppColors.borderColor : AppColors.accentColor,
                width: 3.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: nodeColor.withOpacity(0.6),
                  blurRadius: isLocked ? 5 : 15,
                  spreadRadius: isLocked ? 0 : 5,
                ),
              ],
            ),
            child: level.imageAssetPath != null && level.imageAssetPath!.isNotEmpty
                ? ClipOval(
                    child: Image.asset(
                      level.imageAssetPath!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(icon, color: iconColor, size: 40);
                      },
                    ),
                  )
                : Icon(
                    icon,
                    color: iconColor,
                    size: 40,
                  ),
          ),
          const SizedBox(height: AppConstants.spacing),
          Text(
            'Level ${level.order}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textColorSecondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            level.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

