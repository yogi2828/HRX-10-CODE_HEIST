// gamifier/lib/widgets/common/custom_button.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isSecondary;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isSecondary = false,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.textStyle,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = textStyle ??
        const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        );

    final buttonBorderRadius = borderRadius ?? BorderRadius.circular(AppConstants.borderRadius);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: buttonBorderRadius,
        gradient: isSecondary ? null : AppColors.buttonGradient(),
        boxShadow: [
          if (!isSecondary)
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: buttonBorderRadius,
          child: Ink(
            decoration: BoxDecoration(
              color: isSecondary ? AppColors.cardColor.withOpacity(0.7) : Colors.transparent,
              borderRadius: buttonBorderRadius,
              border: isSecondary ? Border.all(color: AppColors.borderColor, width: 1) : null,
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
                        strokeWidth: 3,
                      ),
                    )
                  : Padding(
                      padding: padding,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) ...[
                            Icon(icon, color: defaultTextStyle.color),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            text,
                            style: defaultTextStyle,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}