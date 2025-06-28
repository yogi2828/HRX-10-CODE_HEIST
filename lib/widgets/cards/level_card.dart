// lib/widgets/cards/level_card.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/level.dart';

class LevelCard extends StatelessWidget {
  final Level level;
  final VoidCallback onTap;
  final bool isCompleted; // New parameter

  const LevelCard({
    super.key,
    required this.level,
    required this.onTap,
    this.isCompleted = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.cardColor.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Level icon/image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.levelColor.withOpacity(0.5) : AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
                  border: Border.all(color: AppColors.levelColor, width: 2),
                ),
                child: Center(
                  child: level.imageAssetPath != null && level.imageAssetPath!.isNotEmpty
                      ? Image.asset(
                          level.imageAssetPath!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.star,
                            size: 40,
                            color: AppColors.levelColor.withOpacity(0.8),
                          ),
                        )
                      : Text(
                          '${level.order}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.levelColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: AppConstants.padding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            level.title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isCompleted)
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.successColor,
                            size: AppConstants.iconSize,
                          ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacing / 2),
                    Text(
                      level.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConstants.spacing),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Chip(
                        label: Text(
                          'Difficulty: ${level.difficulty}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textColor),
                        ),
                        backgroundColor: AppColors.infoColor.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                          side: const BorderSide(color: AppColors.infoColor, width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
