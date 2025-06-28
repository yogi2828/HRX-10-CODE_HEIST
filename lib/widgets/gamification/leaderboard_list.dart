// lib/widgets/gamification/leaderboard_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/services/firebase_service.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserProfile>>(
      stream: Provider.of<FirebaseService>(context).streamLeaderboard(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error loading leaderboard: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No users on the leaderboard yet. Be the first!',
              style: TextStyle(color: AppColors.textColorSecondary),
            ),
          );
        }

        final users = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              color: AppColors.cardColor.withOpacity(0.8),
              margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.padding),
                child: Row(
                  children: [
                    Text(
                      '${index + 1}.',
                      style: AppColors.neonTextStyle(fontSize: 20, color: AppColors.xpColor),
                    ),
                    const SizedBox(width: AppConstants.spacing),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(user.avatarAssetPath),
                      backgroundColor: AppColors.borderColor,
                    ),
                    const SizedBox(width: AppConstants.spacing),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username,
                            style: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Level: ${user.level}',
                            style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${user.xp} XP',
                          style: const TextStyle(color: AppColors.xpColor, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '${user.currentStreak} 🔥',
                          style: const TextStyle(color: AppColors.streakColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}