// lib/widgets/gamification/course_completion_dialog.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:lottie/lottie.dart';

class CourseCompletionDialog extends StatelessWidget {
  final String courseTitle;
  final int totalXpEarned;
  final int newBadgesEarned;
  final VoidCallback onContinue;

  const CourseCompletionDialog({
    super.key,
    required this.courseTitle,
    required this.totalXpEarned,
    required this.newBadgesEarned,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius * 1.5),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/trophy.json', // Path to a trophy animation
              width: 100,
              height: 100,
              repeat: false,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.emoji_events,
                size: 80,
                color: AppColors.xpColor,
              ),
            ),
            const SizedBox(height: AppConstants.padding),
            Text(
              'Course Completed!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.xpColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacing),
            Text(
              'You finished "$courseTitle"!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: AppColors.xpColor, size: AppConstants.iconSize),
                const SizedBox(width: AppConstants.spacing / 2),
                Text(
                  '+$totalXpEarned XP',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.xpColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (newBadgesEarned > 0) ...[
              const SizedBox(height: AppConstants.spacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.military_tech, color: AppColors.levelColor, size: AppConstants.iconSize),
                  const SizedBox(width: AppConstants.spacing / 2),
                  Text(
                    '+$newBadgesEarned New Badges!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.levelColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppConstants.padding),
            ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 1.5, vertical: AppConstants.padding),
              ),
              child: const Text('Awesome!', style: TextStyle(color: AppColors.textColor)),
            ),
          ],
        ),
      ),
    );
  }
}
