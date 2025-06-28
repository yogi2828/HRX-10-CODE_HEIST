// lib/widgets/gamification/badge_display.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/badge.dart' as GamifierBadge; // Alias your custom Badge model

class BadgeDisplay extends StatelessWidget {
  final List<String> badgeIds; // Only display based on IDs for now

  // Placeholder for actual badge data - in a real app, this would come from a service
  static final Map<String, GamifierBadge.Badge> _allBadges = { // Changed to final and use aliased name
    'first_course': const GamifierBadge.Badge( // Use const and aliased name
      id: 'first_course',
      name: 'First Course Conqueror',
      description: 'Completed your first course!',
      icon: Icons.star,
    ),
    'streak_master': const GamifierBadge.Badge( // Use const and aliased name
      id: 'streak_master',
      name: 'Streak Master',
      description: 'Maintained a 7-day learning streak!',
      icon: Icons.local_fire_department,
    ),
    'level_10': const GamifierBadge.Badge( // Use const and aliased name
      id: 'level_10',
      name: 'Level 10 Achiever',
      description: 'Reached level 10!',
      icon: Icons.trending_up,
    ),
    'community_contributor': const GamifierBadge.Badge( // Use const and aliased name
      id: 'community_contributor',
      name: 'Community Contributor',
      description: 'Made 5 community posts!',
      icon: Icons.people,
    ),
    'first_question_correct': const GamifierBadge.Badge( // Use const and aliased name
      id: 'first_question_correct',
      name: 'First Blood',
      description: 'Answered your first question correctly!',
      icon: Icons.check_circle,
    ),
  };

  const BadgeDisplay({
    super.key,
    required this.badgeIds,
  });

  @override
  Widget build(BuildContext context) {
    if (badgeIds.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
      child: Row(
        children: badgeIds.map((id) {
          final badge = _allBadges[id];
          if (badge == null) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing / 2),
            child: Tooltip(
              message: '${badge.name}: ${badge.description}',
              child: Container(
                width: AppConstants.badgeSize,
                height: AppConstants.badgeSize,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryColorDark, AppColors.secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      badge.icon,
                      color: AppColors.xpColor,
                      size: AppConstants.iconSize * 1.5,
                    ),
                    const SizedBox(height: AppConstants.spacing / 2),
                    Text(
                      badge.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}