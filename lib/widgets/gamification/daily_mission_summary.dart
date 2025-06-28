// lib/widgets/gamification/daily_mission_summary.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/daily_mission.dart';

class DailyMissionSummary extends StatelessWidget {
  final List<DailyMission> missions;
  final VoidCallback onViewAll;

  const DailyMissionSummary({
    super.key,
    required this.missions,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final completedMissions = missions.where((m) => m.isCompleted).length;
    final totalMissions = missions.length;

    return Card(
      color: AppColors.cardColor.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Missions Progress',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$completedMissions / $totalMissions Completed',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColorSecondary),
                ),
                TextButton.icon(
                  onPressed: onViewAll,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('View All'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.accentColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacing),
            // Show a preview of uncompleted missions
            if (missions.any((m) => !m.isCompleted))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: missions.where((m) => !m.isCompleted).take(2).map((mission) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppConstants.spacing / 2),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline, color: AppColors.infoColor, size: AppConstants.iconSize * 0.8),
                        const SizedBox(width: AppConstants.spacing),
                        Expanded(
                          child: Text(
                            mission.title,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              Text(
                'All missions completed for today! Great job!',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.successColor),
              ),
          ],
        ),
      ),
    );
  }
}
