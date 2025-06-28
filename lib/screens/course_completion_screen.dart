// lib/screens/course_completion_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:gamifier/utils/app_router.dart'; // New import

class CourseCompletionScreen extends StatelessWidget {
  final String courseTitle;
  final int totalXpEarned;
  final int newBadgesEarned;

  const CourseCompletionScreen({
    super.key,
    required this.courseTitle,
    required this.totalXpEarned,
    this.newBadgesEarned = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: const CustomAppBar(title: 'Course Completed!'),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/trophy.json', // Placeholder for a trophy animation
                  width: 200,
                  height: 200,
                  repeat: false,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.emoji_events,
                    size: 150,
                    color: AppColors.xpColor,
                  ),
                ),
                const SizedBox(height: AppConstants.padding * 2),
                Text(
                  'Congratulations!',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.xpColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.spacing),
                Text(
                  'You have successfully completed the course:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.spacing),
                Text(
                  courseTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.padding * 2),
                Card(
                  color: AppColors.cardColor,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding * 1.5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: AppColors.xpColor, size: AppConstants.iconSize * 1.5),
                            const SizedBox(width: AppConstants.spacing),
                            Text(
                              'Total XP Earned: $totalXpEarned',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.xpColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (newBadgesEarned > 0) ...[
                          const SizedBox(height: AppConstants.padding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.military_tech, color: AppColors.levelColor, size: AppConstants.iconSize * 1.5),
                              const SizedBox(width: AppConstants.spacing),
                              Text(
                                'New Badges: $newBadgesEarned',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.levelColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.padding * 2),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.homeRoute, (route) => false);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Back to Home'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 2, vertical: AppConstants.padding),
                    textStyle: const TextStyle(fontSize: AppConstants.largeTextSize),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
