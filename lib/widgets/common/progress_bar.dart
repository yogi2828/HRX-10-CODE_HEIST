// lib/widgets/common/progress_bar.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final Color backgroundColor;
  final Color progressColor;

  const ProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.backgroundColor = AppColors.progressTrackColor,
    this.progressColor = AppColors.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    double progress = total > 0 ? current / total : 0.0;
    if (progress > 1.0) progress = 1.0; // Cap progress at 100%

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        minHeight: 10,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
    );
  }
}