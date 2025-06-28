// lib/screens/mission_listing_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/daily_mission.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/models/user_progress.dart'; // Import UserProgress
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/services/gemini_api_service.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';
import 'package:gamifier/widgets/cards/mission_card.dart';

class MissionListingScreen extends StatefulWidget {
  const MissionListingScreen({super.key});

  @override
  State<MissionListingScreen> createState() => _MissionListingScreenState();
}

class _MissionListingScreenState extends State<MissionListingScreen> {
  List<DailyMission> _dailyMissions = [];
  UserProfile? _userProfile;
  UserProgress? _userProgressForMissions; // Holds the relevant user progress for missions
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDailyMissions();
  }

  Future<void> _fetchDailyMissions() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
      final user = firebaseService.currentUser;

      if (user == null) {
        // Handle unauthenticated user
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      _userProfile = await firebaseService.streamUserProfile(user.uid).first;

      // Assuming a user might have progress in multiple courses,
      // you need a strategy to determine which UserProgress record
      // contains the daily mission completion status.
      // For simplicity, let's assume we fetch *all* user progress records
      // and then check for mission completion against them.
      // A more robust solution might tie daily missions to a specific "global" progress document
      // or the user profile itself.
      // For this fix, let's get the first user progress found, and check dailyMissionsCompleted on it.
      // If a user can have multiple UserProgress docs, this logic might need refinement.
      final allUserProgresses = await firebaseService.streamAllUserProgressForUser(user.uid).first;
      if (allUserProgresses.isNotEmpty) {
        _userProgressForMissions = allUserProgresses.first;
      } else {
        // If no user progress exists, initialize a dummy one for the current user/course context if needed.
        // Or handle the case where missions can't be tracked without existing progress.
        // For now, _userProgressForMissions will remain null if no progress docs exist.
      }


      String userLearningGoals = _userProfile?.specialty ?? 'general knowledge';
      final aiSuggestedTasks = await geminiApiService.generateAITasks(userLearningGoals);

      _dailyMissions = aiSuggestedTasks.map((task) => DailyMission(
        id: task,
        title: task,
        description: 'AI-suggested daily challenge.',
        xpReward: 10 + (task.length % 5),
        // Check completion status from _userProgressForMissions's dailyMissionsCompleted
        isCompleted: _userProgressForMissions?.dailyMissionsCompleted.contains(task) ?? false,
      )).toList();

    } catch (e) {
      print('Error fetching daily missions: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load daily missions: $e', style: const TextStyle(color: AppColors.errorColor))),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _completeMission(DailyMission mission) async {
    if (_userProfile == null || _userProgressForMissions == null || mission.isCompleted) return;

    final firebaseService = Provider.of<FirebaseService>(context, listen: false);

    try {
      // In a real scenario, you would trigger the actual mission completion logic here.
      // For demonstration, we directly call completeDailyMission.
      await firebaseService.completeDailyMission(_userProfile!.uid, mission.id, mission.xpReward);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mission "${mission.title}" completed! +${mission.xpReward} XP')),
      );
      // Refresh missions to update UI
      _fetchDailyMissions();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to complete mission: ${e.toString()}', style: const TextStyle(color: AppColors.errorColor))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: const CustomAppBar(title: 'Daily Missions'),
        body: _isLoading
            ? const LoadingIndicator()
            : RefreshIndicator(
                onRefresh: _fetchDailyMissions,
                color: AppColors.accentColor,
                backgroundColor: AppColors.cardColor,
                child: _dailyMissions.isEmpty
                    ? Center(
                        child: Text(
                          'No missions available today! Check back later.',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textColorSecondary),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(AppConstants.padding),
                        itemCount: _dailyMissions.length,
                        itemBuilder: (context, index) {
                          final mission = _dailyMissions[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: AppConstants.spacing),
                            child: MissionCard(
                              title: mission.title,
                              description: mission.description,
                              xpReward: mission.xpReward,
                              isCompleted: mission.isCompleted,
                              onComplete: mission.isCompleted ? null : () => _completeMission(mission),
                            ),
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
