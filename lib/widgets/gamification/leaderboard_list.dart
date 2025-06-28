// lib/widgets/gamification/leaderboard_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';

class LeaderboardList extends StatefulWidget {
  const LeaderboardList({super.key});

  @override
  State<LeaderboardList> createState() => _LeaderboardListState();
}

class _LeaderboardListState extends State<LeaderboardList> {
  List<UserProfile> _leaderboardUsers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      _leaderboardUsers = await firebaseService.getLeaderboard();
    } catch (e) {
      print('Error fetching leaderboard: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load leaderboard: $e', style: const TextStyle(color: AppColors.errorColor))),
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
      return const LoadingIndicator();
    }
    if (_leaderboardUsers.isEmpty) {
      return Center(
        child: Text(
          'No leaderboard data yet. Start earning XP!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
        ),
      );
    }

    return Card(
      color: AppColors.secondaryColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        side: const BorderSide(color: AppColors.borderColor),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Rank', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textColorSecondary))),
                Expanded(
                    flex: 4,
                    child: Text('Player', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textColorSecondary))),
                Expanded(
                    flex: 2,
                    child: Text('Level', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textColorSecondary), textAlign: TextAlign.right)),
                Expanded(
                    flex: 2,
                    child: Text('XP', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.textColorSecondary), textAlign: TextAlign.right)),
              ],
            ),
            const Divider(color: AppColors.borderColor),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _leaderboardUsers.length,
              itemBuilder: (context, index) {
                final user = _leaderboardUsers[index];
                final rank = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          '$rank',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(user.avatarAssetPath),
                              radius: 16,
                            ),
                            const SizedBox(width: AppConstants.spacing),
                            Text(
                              user.username,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${user.level}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.levelColor),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${user.xp}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.xpColor),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
