// lib/screens/leaderboard_page.dart
import 'package:flutter/material.dart';
import 'package:gamifier/widgets/navigation/top_nav_bar.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/widgets/gamification/leaderboard_list.dart'; // Re-use the existing LeaderboardList
import 'package:gamifier/widgets/common/night_sky_background.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopNavBar(
        currentIndex: 6, // Leaderboard is index 6
        title: 'Global Leaderboard',
        appLogoPath: AppConstants.appIconPath, // Add your app logo here
      ),
      body: NightSkyBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Players by XP',
                  style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.xpColor),
                ),
                const SizedBox(height: AppConstants.spacing * 2),
                const LeaderboardList(), // The actual leaderboard content
                const SizedBox(height: AppConstants.spacing * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}