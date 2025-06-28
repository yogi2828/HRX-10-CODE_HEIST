// lib/widgets/common/ai_persona_selector.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';

class AIPersonaSelector extends StatelessWidget {
  final String? selectedPersona;
  final ValueChanged<String?> onChanged;

  const AIPersonaSelector({
    super.key,
    required this.selectedPersona,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedPersona,
      decoration: InputDecoration(
        labelText: 'AI Tutor Persona',
        prefixIcon: const Icon(Icons.smart_toy, color: AppColors.accentColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.secondaryColor.withOpacity(0.3),
      ),
      items: const [
        DropdownMenuItem<String>(value: 'Default', child: Text('Default', style: TextStyle(color: AppColors.textColor))),
        DropdownMenuItem<String>(value: 'Strict Professor', child: Text('Strict Professor', style: TextStyle(color: AppColors.textColor))),
        DropdownMenuItem<String>(value: 'Friendly Guide', child: Text('Friendly Guide', style: TextStyle(color: AppColors.textColor))),
        DropdownMenuItem<String>(value: 'Sarcastic Mentor', child: Text('Sarcastic Mentor', style: TextStyle(color: AppColors.textColor))),
      ].toList(),
      onChanged: onChanged,
      dropdownColor: AppColors.cardColor,
      style: const TextStyle(color: AppColors.textColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an AI persona.';
        }
        return null;
      },
    );
  }
}
