// lib/widgets/feedback/personalized_feedback_modal.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:lottie/lottie.dart';

class PersonalizedFeedbackModal extends StatelessWidget {
  final String feedback;
  final bool isCorrect; // Added for correct/incorrect visual feedback

  const PersonalizedFeedbackModal({
    super.key,
    required this.feedback,
    this.isCorrect = true, // Default to correct feedback
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
              isCorrect
                  ? 'assets/animations/correct.json' // Path to a correct animation
                  : 'assets/animations/incorrect.json', // Path to an incorrect animation
              width: 100,
              height: 100,
              repeat: false,
              errorBuilder: (context, error, stackTrace) => Icon(
                isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
                size: 80,
                color: isCorrect ? AppColors.successColor : AppColors.errorColor,
              ),
            ),
            const SizedBox(height: AppConstants.padding),
            Text(
              isCorrect ? 'Great Job!' : 'Keep Trying!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: isCorrect ? AppColors.successColor : AppColors.errorColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacing),
            Text(
              feedback,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.padding),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 1.5, vertical: AppConstants.padding),
              ),
              child: const Text('Got It!', style: TextStyle(color: AppColors.textColor)),
            ),
          ],
        ),
      ),
    );
  }
}
