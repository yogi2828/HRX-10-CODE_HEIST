// lib/widgets/course/course_card.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
        color: AppColors.cardColor.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: AppColors.errorColor),
                  onPressed: onDelete,
                  tooltip: 'Delete Course',
                ),
              ),
              Text(
                course.title,
                style: AppColors.neonTextStyle(fontSize: 22, color: AppColors.accentColor),
              ),
              const SizedBox(height: AppConstants.spacing),
              Text(
                course.description,
                style: const TextStyle(
                  color: AppColors.textColorSecondary,
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConstants.spacing * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoChip(
                    icon: Icons.category,
                    label: course.gameGenre,
                    color: AppColors.primaryColor,
                  ),
                  _buildInfoChip(
                    icon: Icons.trending_up,
                    label: course.difficulty,
                    color: AppColors.levelColor,
                  ),
                  _buildInfoChip(
                    icon: Icons.layers,
                    label: '${course.levelIds.length} Levels',
                    color: AppColors.xpColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing, vertical: AppConstants.spacing / 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: AppConstants.spacing / 2),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}