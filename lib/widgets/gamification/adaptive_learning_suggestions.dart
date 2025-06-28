// lib/widgets/gamification/adaptive_learning_suggestions.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class AdaptiveLearningSuggestions extends StatelessWidget {
  final String suggestionText;
  final VoidCallback onAction;
  final String actionButtonText;
  final IconData actionIcon;

  const AdaptiveLearningSuggestions({
    super.key,
    required this.suggestionText,
    required this.onAction,
    required this.actionButtonText,
    this.actionIcon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.infoColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        side: const BorderSide(color: AppColors.infoColor),
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Learning Suggestion:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.infoColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacing),
            Text(
              suggestionText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
            ),
            const SizedBox(height: AppConstants.padding),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: onAction,
                icon: Icon(actionIcon),
                label: Text(actionButtonText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.infoColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
