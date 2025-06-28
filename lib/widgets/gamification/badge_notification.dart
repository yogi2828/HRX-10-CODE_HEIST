// lib/widgets/gamification/badge_notification.dart
import 'package:flutter/material.dart' hide Badge; // Hide Flutter's Badge
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/badge.dart'; // Our custom Badge model
import 'package:lottie/lottie.dart';

class BadgeNotification extends StatelessWidget {
  final Badge badge;
  final VoidCallback onDismiss;

  const BadgeNotification({
    super.key,
    required this.badge,
    required this.onDismiss,
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
              'assets/animations/badge_unlock.json', // Path to a badge unlock animation
              width: 100,
              height: 100,
              repeat: false,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.military_tech,
                size: 80,
                color: AppColors.levelColor,
              ),
            ),
            const SizedBox(height: AppConstants.padding),
            Text(
              'Badge Unlocked!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.levelColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacing),
            Image.network(
              badge.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.military_tech,
                size: 80,
                color: AppColors.textColorSecondary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: AppConstants.spacing),
            Text(
              badge.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacing),
            Text(
              badge.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.padding),
            ElevatedButton(
              onPressed: onDismiss,
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
