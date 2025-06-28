// lib/widgets/common/custom_text_field.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final void Function(String)? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool readOnly; // Added readOnly parameter

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.icon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.onSubmitted,
    this.onChanged,
    this.readOnly = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      readOnly: readOnly, // Pass readOnly to TextFormField
      style: const TextStyle(color: AppColors.textColor, fontSize: 16),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon, color: AppColors.textColorSecondary) : null,
        labelStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.8)),
        hintStyle: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.5)),
        filled: true,
        fillColor: AppColors.cardColor.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1.0),
        ),
        errorStyle: const TextStyle(color: AppColors.errorColor, fontSize: 12),
      ),
      cursorColor: AppColors.accentColor,
    );
  }
}