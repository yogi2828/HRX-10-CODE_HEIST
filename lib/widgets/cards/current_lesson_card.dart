// lib/widgets/cards/current_lesson_card.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/lesson.dart';

class CurrentLessonCard extends StatelessWidget {
  final String courseTitle;
  final String levelTitle;
  final Lesson? currentLesson;
  final VoidCallback onContinueLearning;

  const CurrentLessonCard({
    super.key,
    required this.courseTitle,
    required this.levelTitle,
    this.currentLesson,
    required this.onContinueLearning,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardColor.withOpacity(0.9),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Continue Your Journey',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacing),
            Text(
              'Course: $courseTitle',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
            ),
            Text(
              'Level: $levelTitle',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
            ),
            if (currentLesson != null) ...[
              const SizedBox(height: AppConstants.spacing),
              Text(
                'Current Lesson: ${currentLesson!.title}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
              ),
              const SizedBox(height: AppConstants.spacing),
              Text(
                currentLesson!.content,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ] else ...[
              const SizedBox(height: AppConstants.spacing),
              Text(
                'No active lesson. Start a new one!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
              ),
            ],
            const SizedBox(height: AppConstants.padding),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: onContinueLearning,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Continue Learning'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
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
