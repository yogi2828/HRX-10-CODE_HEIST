// lib/screens/level_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/course.dart';
import 'package:gamifier/models/level.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';
import 'package:gamifier/widgets/cards/level_card.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/models/user_progress.dart'; // New: for user progress
import 'package:gamifier/models/user_profile.dart'; // New: for user profile

class LevelSelectionScreen extends StatefulWidget {
  final String courseId;

  const LevelSelectionScreen({super.key, required this.courseId});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  Course? _course;
  List<Level> _levels = [];
  UserProgress? _userProgress;
  UserProfile? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCourseAndLevels();
  }

  Future<void> _fetchCourseAndLevels() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      final currentUser = firebaseService.currentUser;

      if (currentUser == null) {
        // Handle unauthenticated user
        return;
      }

      _userProfile = await firebaseService.streamUserProfile(currentUser.uid).first;
      _course = await firebaseService.getCourse(widget.courseId);
      _levels = await firebaseService.getLevelsForCourse(widget.courseId);
      _levels.sort((a, b) => a.order.compareTo(b.order)); // Ensure levels are sorted

      _userProgress = await firebaseService.streamUserProgress(currentUser.uid, widget.courseId).first;

    } catch (e) {
      print('Error fetching course and levels: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load content: $e', style: const TextStyle(color: AppColors.errorColor))),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // New: Adaptive Learning - Recommend next level/lesson
  Level? _getRecommendedLevel() {
    if (_userProgress == null || _levels.isEmpty) return null;

    // Find the first uncompleted level
    for (final level in _levels) {
      if (!_userProgress!.levelsCompleted.contains(level.id)) {
        return level; // Recommend the next uncompleted level
      }
    }
    // If all levels completed, recommend the last one or a "mastery" level
    return _levels.last;
  }

  @override
  Widget build(BuildContext context) {
    final recommendedLevel = _getRecommendedLevel();

    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: CustomAppBar(title: _course?.title ?? 'Select Level'),
        body: _isLoading
            ? const LoadingIndicator()
            : RefreshIndicator(
                onRefresh: _fetchCourseAndLevels,
                color: AppColors.accentColor,
                backgroundColor: AppColors.cardColor,
                child: Column(
                  children: [
                    if (recommendedLevel != null)
                      Padding(
                        padding: const EdgeInsets.all(AppConstants.padding),
                        child: Card(
                          color: AppColors.infoColor.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                            side: const BorderSide(color: AppColors.infoColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppConstants.padding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recommended Next:',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.infoColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: AppConstants.spacing),
                                Text(
                                  recommendedLevel.title,
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textColor),
                                ),
                                Text(
                                  recommendedLevel.description,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textColorSecondary),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: AppConstants.spacing),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        AppRouter.lessonRoute,
                                        arguments: {'courseId': widget.courseId, 'levelId': recommendedLevel.id},
                                      );
                                    },
                                    icon: const Icon(Icons.play_arrow),
                                    label: const Text('Start Recommended'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.infoColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: _levels.isEmpty
                          ? Center(
                              child: Text(
                                'No levels available for this course yet.',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textColorSecondary),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(AppConstants.padding),
                              itemCount: _levels.length,
                              itemBuilder: (context, index) {
                                final level = _levels[index];
                                final bool isCompleted = _userProgress?.levelsCompleted.contains(level.id) ?? false;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
                                  child: LevelCard(
                                    level: level,
                                    isCompleted: isCompleted, // Pass completion status
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        AppRouter.lessonRoute,
                                        arguments: {'courseId': widget.courseId, 'levelId': level.id},
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: Implement "Add Level" functionality or navigate to a level creation screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Level creation coming soon!')),
            );
          },
          backgroundColor: AppColors.accentColor,
          child: const Icon(Icons.add, color: AppColors.textColor),
        ),
      ),
    );
  }
}
