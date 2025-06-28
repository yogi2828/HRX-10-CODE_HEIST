// lib/widgets/gamification/badge_display.dart
import 'package:flutter/material.dart' hide Badge; // Hide Flutter's Badge
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/badge.dart'; // Our custom Badge model
import 'package:gamifier/services/firebase_service.dart';
import 'package:provider/provider.dart';

class BadgeDisplay extends StatefulWidget {
  final List<String> earnedBadgeIds;

  const BadgeDisplay({super.key, required this.earnedBadgeIds});

  @override
  State<BadgeDisplay> createState() => _BadgeDisplayState();
}

class _BadgeDisplayState extends State<BadgeDisplay> {
  List<Badge> _allBadges = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAllBadges();
  }

  Future<void> _fetchAllBadges() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      _allBadges = await firebaseService.getAllBadges();
    } catch (e) {
      print('Error fetching badges: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load badges: $e', style: const TextStyle(color: AppColors.errorColor))),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
    }
    if (_allBadges.isEmpty) {
      return Center(
        child: Text(
          'No badges defined yet.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
        ),
      );
    }

    final earnedBadges = _allBadges.where((badge) => widget.earnedBadgeIds.contains(badge.id)).toList();
    final unearnedBadges = _allBadges.where((badge) => !widget.earnedBadgeIds.contains(badge.id)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (earnedBadges.isNotEmpty) ...[
          Text(
            'Your Collection:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.spacing),
          Wrap(
            spacing: AppConstants.spacing,
            runSpacing: AppConstants.spacing,
            children: earnedBadges.map((badge) => _buildBadgeItem(badge, true)).toList(),
          ),
          const SizedBox(height: AppConstants.padding),
        ],
        if (unearnedBadges.isNotEmpty) ...[
          Text(
            'Unlock More Badges:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.spacing),
          Wrap(
            spacing: AppConstants.spacing,
            runSpacing: AppConstants.spacing,
            children: unearnedBadges.map((badge) => _buildBadgeItem(badge, false)).toList(),
          ),
        ],
        if (earnedBadges.isEmpty && unearnedBadges.isEmpty)
          Center(
            child: Text(
              'No badges available yet. Keep learning!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
            ),
          ),
      ],
    );
  }

  Widget _buildBadgeItem(Badge badge, bool isEarned) {
    return Tooltip(
      message: '${badge.name}: ${badge.description}',
      child: Opacity(
        opacity: isEarned ? 1.0 : 0.5,
        child: Container(
          width: AppConstants.badgeSize * 1.5,
          height: AppConstants.badgeSize * 1.5,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withOpacity(isEarned ? 0.8 : 0.3),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
            border: Border.all(
              color: isEarned ? AppColors.levelColor : AppColors.borderColor,
              width: 2,
            ),
            boxShadow: isEarned
                ? [
                    BoxShadow(
                      color: AppColors.levelColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                badge.imageUrl,
                width: AppConstants.badgeSize,
                height: AppConstants.badgeSize,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.military_tech,
                  size: AppConstants.badgeSize,
                  color: AppColors.textColorSecondary.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: AppConstants.spacing / 2),
              Text(
                badge.name,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isEarned ? AppColors.textColor : AppColors.textColorSecondary,
                  fontWeight: isEarned ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
