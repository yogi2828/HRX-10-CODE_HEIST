// lib/screens/progress_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/models/user_progress.dart'; // New: for user progress details
import 'package:gamifier/models/course.dart'; // New: for course titles
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';
import 'package:gamifier/widgets/common/progress_bar.dart';
import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
import 'package:gamifier/utils/app_extensions.dart'; // For isSameDay extension

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  UserProfile? _userProfile;
  List<UserProgress> _allUserProgress = [];
  Map<String, Course> _coursesMap = {}; // Map courseId to Course object
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProgressData();
  }

  Future<void> _fetchProgressData() async {
    setState(() {
      _isLoading = true;
    });
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final user = firebaseService.currentUser;
    if (user != null) {
      firebaseService.streamUserProfile(user.uid).listen((profile) async {
        if (mounted) {
          setState(() {
            _userProfile = profile;
          });

          // Fetch all courses to map IDs to titles
          final allCourses = await firebaseService.getCourses();
          _coursesMap = {for (var course in allCourses) course.id: course};

          // Fetch all user progress entries for the current user
          _allUserProgress = (await firebaseService.streamUserProgress(user.uid, '').firstWhere(
            (data) => true, // Wait for first data
            orElse: () => null, // If no data, return null
          ) != null) ? await firebaseService.streamUserProgress(user.uid, '').first.then((p) => [p!]) : [];

          // Note: streamUserProgress currently fetches a single course's progress.
          // To get 'allUserProgress', you'd typically query all user_progress documents
          // where userId matches, without filtering by courseId. This would require
          // modifying FirebaseService.streamUserProgress or adding a new method.
          // For now, _allUserProgress will only contain progress for one course if available.

          setState(() {
            _isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: const CustomAppBar(title: 'My Progress'),
        body: _isLoading
            ? const LoadingIndicator()
            : _userProfile == null
                ? Center(
                    child: Text(
                      'Please log in to view your progress.',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textColorSecondary),
                      textAlign: TextAlign.center,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _fetchProgressData,
                    color: AppColors.accentColor,
                    backgroundColor: AppColors.cardColor,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppConstants.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            color: AppColors.cardColor,
                            margin: const EdgeInsets.only(bottom: AppConstants.padding),
                            child: Padding(
                              padding: const EdgeInsets.all(AppConstants.padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Overall Progress',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
                                  ),
                                  const SizedBox(height: AppConstants.padding),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Level: ${_userProfile!.level}',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.levelColor),
                                      ),
                                      Text(
                                        'XP: ${_userProfile!.xp}/${_userProfile!.level * AppConstants.xpPerLevel}',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.xpColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppConstants.spacing),
                                  ProgressBar(
                                    current: _userProfile!.xp,
                                    total: _userProfile!.level * AppConstants.xpPerLevel,
                                    color: AppColors.xpColor,
                                    backgroundColor: AppColors.borderColor,
                                  ),
                                  const SizedBox(height: AppConstants.padding),
                                  Text(
                                    'Daily Streak: ${_userProfile!.currentStreak} days',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.streakColor),
                                  ),
                                  const SizedBox(height: AppConstants.spacing),
                                  Text(
                                    _userProfile!.lastStreakUpdate != null
                                        ? 'Last activity: ${_userProfile!.lastStreakUpdate!.toLocal().toIso8601String().substring(0, 10)}'
                                        : 'No recent activity',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: AppColors.cardColor,
                            margin: const EdgeInsets.only(bottom: AppConstants.padding),
                            child: Padding(
                              padding: const EdgeInsets.all(AppConstants.padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Course Progress',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
                                  ),
                                  const SizedBox(height: AppConstants.padding),
                                  if (_allUserProgress.isEmpty)
                                    Text(
                                      'No course progress yet. Start a course to see your progress!',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
                                    )
                                  else
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: _allUserProgress.length,
                                      itemBuilder: (context, index) {
                                        final progress = _allUserProgress[index];
                                        final course = _coursesMap[progress.courseId];
                                        if (course == null) return const SizedBox.shrink();

                                        final completedLessons = progress.lessonsProgress.values.where((lp) => lp.isCompleted).length;
                                        final totalLessons = course.levelIds.length; // Simplified: assuming 1 lesson per level for now

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              course.title,
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
                                            ),
                                            const SizedBox(height: AppConstants.spacing / 2),
                                            ProgressBar(
                                              current: completedLessons,
                                              total: totalLessons,
                                              color: AppColors.accentColor,
                                              backgroundColor: AppColors.borderColor,
                                            ),
                                            const SizedBox(height: AppConstants.spacing / 2),
                                            Text(
                                              '$completedLessons / $totalLessons lessons completed',
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColorSecondary),
                                            ),
                                            const Divider(color: AppColors.borderColor, height: AppConstants.padding),
                                          ],
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: AppColors.cardColor,
                            margin: const EdgeInsets.only(bottom: AppConstants.padding),
                            child: Padding(
                              padding: const EdgeInsets.all(AppConstants.padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Achievements & Badges',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
                                  ),
                                  const SizedBox(height: AppConstants.padding),
                                  Text(
                                    'Visit the Profile screen to view your earned badges and achievements.',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(AppRouter.profileRoute);
                                      },
                                      icon: const Icon(Icons.arrow_forward),
                                      label: const Text('Go to Profile'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColors.accentColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      ),
    );
  }
}
