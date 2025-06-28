// lib/widgets/common/progress_bar.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final Color color;
  final Color backgroundColor;
  final double height;
  final double borderRadius;

  const ProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.color = AppColors.accentColor,
    this.backgroundColor = AppColors.secondaryColor,
    this.height = 10.0,
    this.borderRadius = AppConstants.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double percentage = total > 0 ? current / total : 0.0;
        if (percentage > 1.0) percentage = 1.0; // Cap at 100%

        return Container(
          width: constraints.maxWidth,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: AppConstants.defaultAnimationDuration,
                width: constraints.maxWidth * percentage,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
