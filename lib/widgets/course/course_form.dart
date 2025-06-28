// lib/widgets/course/course_form.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/widgets/common/custom_text_field.dart';
import 'package:gamifier/utils/validation_utils.dart';

class CourseForm extends StatelessWidget {
  final ValueChanged<String> onTopicChanged;
  final ValueChanged<String> onDomainChanged;
  final ValueChanged<String?> onDifficultyChanged;
  final ValueChanged<String?> onEducationLevelChanged;
  final ValueChanged<String?> onGameGenreChanged;
  final ValueChanged<String> onYoutubeUrlChanged;
  final ValueChanged<String> onSourceContentChanged; // Not directly used here, but keeps signature consistent
  final String currentDifficulty;
  final String currentEducationLevel;
  final String currentGameGenre;

  const CourseForm({
    super.key,
    required this.onTopicChanged,
    required this.onDomainChanged,
    required this.onDifficultyChanged,
    required this.onEducationLevelChanged,
    required this.onGameGenreChanged,
    required this.onYoutubeUrlChanged,
    required this.onSourceContentChanged,
    required this.currentDifficulty,
    required this.currentEducationLevel,
    required this.currentGameGenre,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          labelText: 'Course Topic (e.g., "Quantum Physics")',
          icon: Icons.topic,
          onChanged: onTopicChanged,
          validator: (value) => ValidationUtils.validateField(value, 'Course Topic'),
        ),
        const SizedBox(height: AppConstants.spacing * 2),
        CustomTextField(
          labelText: 'Domain (e.g., "Science", "Technology")',
          icon: Icons.domain,
          onChanged: onDomainChanged,
          validator: (value) => ValidationUtils.validateField(value, 'Domain'),
        ),
        const SizedBox(height: AppConstants.spacing * 2),
        _buildDropdownField(
          label: 'Difficulty',
          value: currentDifficulty,
          items: AppConstants.difficultyLevels,
          onChanged: onDifficultyChanged,
          icon: Icons.signal_cellular_alt,
        ),
        const SizedBox(height: AppConstants.spacing * 2),
        _buildDropdownField(
          label: 'Education Level',
          value: currentEducationLevel,
          items: AppConstants.educationLevels,
          onChanged: onEducationLevelChanged,
          icon: Icons.school,
        ),
        const SizedBox(height: AppConstants.spacing * 2),
        _buildDropdownField(
          label: 'Game Genre',
          value: currentGameGenre,
          items: AppConstants.gameThemes,
          onChanged: onGameGenreChanged,
          icon: Icons.gamepad,
        ),
        const SizedBox(height: AppConstants.spacing * 2),
        CustomTextField(
          labelText: 'YouTube URL (Optional, for video lessons)',
          icon: Icons.video_library,
          onChanged: onYoutubeUrlChanged,
          keyboardType: TextInputType.url,
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.cardColor,
          icon: Icon(Icons.arrow_drop_down, color: AppColors.textColorSecondary),
          style: const TextStyle(color: AppColors.textColor, fontSize: 16),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String itemValue) {
            return DropdownMenuItem<String>(
              value: itemValue,
              child: Row(
                children: [
                  Icon(icon, color: AppColors.textColorSecondary, size: 20),
                  SizedBox(width: AppConstants.spacing),
                  Text(itemValue),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}