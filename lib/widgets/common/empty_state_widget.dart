// lib/widgets/common/empty_state_widget.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:lottie/lottie.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? animationPath;
  final IconData? icon;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.animationPath,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (animationPath != null)
              Lottie.asset(
                animationPath!,
                width: 150,
                height: 150,
                repeat: true,
                errorBuilder: (context, error, stackTrace) => icon != null
                    ? Icon(icon, size: 100, color: AppColors.textColorSecondary.withOpacity(0.5))
                    : const SizedBox.shrink(),
              )
            else if (icon != null)
              Icon(icon, size: 100, color: AppColors.textColorSecondary.withOpacity(0.5)),
            const SizedBox(height: AppConstants.padding),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textColorSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
