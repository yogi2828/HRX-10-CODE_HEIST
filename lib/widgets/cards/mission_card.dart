// lib/widgets/cards/mission_card.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class MissionCard extends StatelessWidget {
  final String title;
  final String description;
  final int xpReward;
  final VoidCallback? onComplete; // Make nullable for completed missions
  final bool isCompleted; // New: to show completion status

  const MissionCard({
    super.key,
    required this.title,
    required this.description,
    required this.xpReward,
    this.onComplete,
    this.isCompleted = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardColor.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.stars, color: AppColors.accentColor, size: AppConstants.iconSize),
                const SizedBox(width: AppConstants.spacing),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacing),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
            const SizedBox(height: AppConstants.spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  avatar: const Icon(Icons.emoji_events, color: AppColors.xpColor, size: AppConstants.iconSize * 0.8),
                  label: Text(
                    '+$xpReward XP',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.xpColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: AppColors.xpColor.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    side: const BorderSide(color: AppColors.xpColor, width: 1),
                  ),
                ),
                isCompleted
                    ? Chip(
                        avatar: const Icon(Icons.check_circle, color: AppColors.successColor, size: AppConstants.iconSize * 0.8),
                        label: Text(
                          'Completed!',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: AppColors.successColor.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                          side: const BorderSide(color: AppColors.successColor, width: 1),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: onComplete,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.successColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
                        ),
                        child: const Text('Complete', style: TextStyle(color: AppColors.textColor)),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
