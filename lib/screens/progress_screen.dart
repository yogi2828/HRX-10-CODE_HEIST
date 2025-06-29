// lib/screens/progress_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/widgets/navigation/top_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/course.dart';
import 'package:gamifier/models/user_progress.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/widgets/common/progress_bar.dart';
import 'package:gamifier/widgets/common/night_sky_background.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late FirebaseService _firebaseService;
  String? _currentUserId;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    _initializeUserAndLoadProgress();
  }

  Future<void> _initializeUserAndLoadProgress() async {
    final user = _firebaseService.currentUser;
    if (user != null) {
      setState(() {
        _currentUserId = user.uid;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = 'User not logged in.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopNavBar(
        currentIndex: 1, // Progress is index 1
        title: 'My Progress',
        appLogoPath: AppConstants.appIconPath, // Add your app logo here
      ),
      body: NightSkyBackground(
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
              : _errorMessage != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.padding),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: AppColors.errorColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(AppConstants.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Course Progress',
                            style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.accentColor),
                          ),
                          const SizedBox(height: AppConstants.spacing * 2),
                          StreamBuilder<List<Course>>(
                            stream: _firebaseService.streamAllCourses(),
                            builder: (context, courseSnapshot) {
                              if (courseSnapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
                              }
                              if (courseSnapshot.hasError) {
                                return Center(child: Text('Error loading courses: ${courseSnapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
                              }
                              if (!courseSnapshot.hasData || courseSnapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text(
                                    'No courses available to track progress. Create one to get started!',
                                    style: TextStyle(color: AppColors.textColorSecondary),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }

                              final courses = courseSnapshot.data!;

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: courses.length,
                                itemBuilder: (context, index) {
                                  final course = courses[index];
                                  return StreamBuilder<UserProgress?>(
                                    stream: _firebaseService.streamUserCourseProgress(_currentUserId!, course.id),
                                    builder: (context, progressSnapshot) {
                                      if (progressSnapshot.connectionState == ConnectionState.waiting) {
                                        return CourseProgressCard(course: course, progressPercentage: 0, lessonsCompleted: 0, totalLessons: 0, totalXpEarned: 0, isLoading: true);
                                      }
                                      if (progressSnapshot.hasError) {
                                        return CourseProgressCard(course: course, progressPercentage: 0, lessonsCompleted: 0, totalLessons: 0, totalXpEarned: 0, isError: true);
                                      }

                                      final userProgress = progressSnapshot.data;

                                      int totalLevelsInCourse = course.levelIds.length;
                                      int completedLevelsCount = 0;
                                      int totalXpEarned = 0;

                                      if (userProgress != null) {
                                        completedLevelsCount = userProgress.levelsProgress.values.where((p) => p.isCompleted).length;
                                        totalXpEarned = userProgress.levelsProgress.values.fold(0, (sum, progress) => sum + progress.xpEarned);
                                      }

                                      double progressPercentage = totalLevelsInCourse > 0
                                          ? (completedLevelsCount / totalLevelsInCourse)
                                          : 0.0;

                                      return CourseProgressCard(
                                        course: course,
                                        progressPercentage: progressPercentage,
                                        lessonsCompleted: completedLevelsCount,
                                        totalLessons: totalLevelsInCourse,
                                        totalXpEarned: totalXpEarned,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: AppConstants.spacing * 2),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class CourseProgressCard extends StatelessWidget {
  final Course course;
  final double progressPercentage;
  final int lessonsCompleted;
  final int totalLessons;
  final int totalXpEarned;
  final bool isLoading;
  final bool isError;

  const CourseProgressCard({
    super.key,
    required this.course,
    required this.progressPercentage,
    required this.lessonsCompleted,
    required this.totalLessons,
    required this.totalXpEarned,
    this.isLoading = false,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
      color: AppColors.cardColor.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
            : isError
                ? const Center(child: Text('Error loading progress', style: TextStyle(color: AppColors.errorColor)))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                          color: AppColors.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing),
                      Text(
                        course.description,
                        style: const TextStyle(
                          color: AppColors.textColorSecondary,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppConstants.spacing * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress: ${(progressPercentage * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'XP: $totalXpEarned',
                            style: const TextStyle(color: AppColors.xpColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.spacing),
                      ProgressBar(
                        current: (progressPercentage * 100).round(),
                        total: 100,
                        backgroundColor: AppColors.progressTrackColor,
                        progressColor: AppColors.accentColor,
                      ),
                      const SizedBox(height: AppConstants.spacing),
                      Text(
                        'Levels Completed: ${lessonsCompleted}/${totalLessons}',
                        style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 12),
                      ),
                    ],
                  ),
      ),
    );
  }
}



