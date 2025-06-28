// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/lesson.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/models/course.dart';
import 'package:gamifier/models/user_progress.dart';
import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
import 'package:gamifier/widgets/cards/course_card.dart';
import 'package:gamifier/widgets/cards/current_lesson_card.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/xp_level_display.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/models/level.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);
    final currentUser = firebaseService.currentUser;

    if (currentUser == null) {
      // If no user is logged in, navigate to AuthScreen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Welcome Back!',
        leadingWidget: StreamBuilder<UserProfile?>(
          stream: firebaseService.streamUserProfile(currentUser.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(strokeWidth: 2);
            }
            if (snapshot.hasError) {
              return const Icon(Icons.error, color: AppColors.errorColor);
            }
            final userProfile = snapshot.data;
            if (userProfile == null) {
              return const CircleAvatar(
                backgroundColor: AppColors.cardColor,
                child: Icon(Icons.person, color: AppColors.textColorSecondary),
              );
            }
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouter.profileRoute);
              },
              child: CircleAvatar(
                radius: 24, // Smaller radius for app bar
                backgroundColor: AppColors.cardColor,
                backgroundImage: AssetImage(userProfile.avatarAssetPath),
                onBackgroundImageError: (exception, stackTrace) {
                  debugPrint('Error loading avatar image: $exception');
                },
              ),
            );
          },
        ),
        trailingWidget: StreamBuilder<UserProfile?>(
          stream: firebaseService.streamUserProfile(currentUser.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }
            if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
              return const SizedBox.shrink();
            }
            final userProfile = snapshot.data!;
            return Row(
              children: [
                // Streak Display
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacing,
                    vertical: AppConstants.spacing / 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    border: Border.all(color: AppColors.borderColor, width: 1.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_fire_department, color: AppColors.xpColor, size: AppConstants.iconSize * 0.8), // 🔥 icon, smaller
                      const SizedBox(width: AppConstants.spacing / 2),
                      Text(
                        '${userProfile.currentStreak} 🔥',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.xpColor,
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstants.smallTextSize, // Smaller text
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppConstants.spacing),
                XpLevelDisplay(
                  xp: userProfile.xp,
                  level: userProfile.level,
                  showLabel: false, // Don't show "XP:" and "Level:" in app bar
                ),
              ],
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(),
        ),
        child: _HomeContent(
          onItemTapped: (index) {
            setState(() {
              _selectedIndex = index;
            });
            switch (index) {
              case 0:
                break;
              case 1:
                Navigator.of(context).pushNamed(AppRouter.courseCreationRoute);
                break;
              case 2:
                Navigator.of(context).pushNamed(AppRouter.progressRoute);
                break;
              case 3:
                Navigator.of(context).pushNamed(AppRouter.profileRoute);
                break;
              case 4:
                Navigator.of(context).pushNamed(AppRouter.communityRoute);
                break;
              case 5: // AI Chatbot
                Navigator.of(context).pushNamed(AppRouter.aiChatRoute);
                break;
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.of(context).pushNamed(AppRouter.courseCreationRoute);
              break;
            case 2:
              Navigator.of(context).pushNamed(AppRouter.progressRoute);
              break;
            case 3:
              Navigator.of(context).pushNamed(AppRouter.profileRoute);
              break;
            case 4:
              Navigator.of(context).pushNamed(AppRouter.communityRoute);
              break;
            case 5: // AI Chatbot
              Navigator.of(context).pushNamed(AppRouter.aiChatRoute);
              break;
          }
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final Function(int) onItemTapped;
  const _HomeContent({required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);
    final currentUser = firebaseService.currentUser;

    if (currentUser == null) {
      return const Center(child: Text('User not logged in.', style: TextStyle(color: AppColors.textColor)));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Continue Learning',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.largeTextSize, // Adjusted text size
                ),
          ),
          const SizedBox(height: AppConstants.spacing),
          // Stream to find the most recent user progress
          StreamBuilder<List<UserProgress>>(
            stream: firebaseService.streamAllUserProgressForUser(currentUser.uid),
            builder: (context, progressSnapshot) {
              if (progressSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
              }
              if (progressSnapshot.hasError) {
                return Center(
                    child: Text('Error loading progress: ${progressSnapshot.error}',
                        style: const TextStyle(color: AppColors.errorColor)));
              }

              final List<UserProgress> allUserProgress = progressSnapshot.data ?? [];

              // Find the most recently active progress
              UserProgress? activeProgress;
              // Sort by last updated or creation date if available, or just pick the first ongoing
              for (var progress in allUserProgress) {
                if (progress.currentLevelId != null && progress.currentLessonId != null) {
                  activeProgress = progress;
                  // If multiple, you might want to sort by latest activity, but for simplicity, first active
                  break;
                }
              }

              if (activeProgress == null) {
                return Card(
                  color: AppColors.cardColor.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'No ongoing lessons.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textColorSecondary,
                            fontSize: AppConstants.mediumTextSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConstants.spacing),
                        Text(
                          'Start a new course or revisit a previous one from "My Courses" below!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textColorSecondary.withOpacity(0.8),
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return FutureBuilder<Lesson?>(
                future: firebaseService.getLesson(activeProgress.currentLevelId!, activeProgress.currentLessonId!),
                builder: (context, lessonSnapshot) {
                  if (lessonSnapshot.connectionState == ConnectionState.waiting) {
                    return const CurrentLessonCard(
                      courseTitle: 'Loading Course...',
                      lessonTitle: 'Loading Lesson...',
                      progress: 0.0,
                      onTap: null,
                    );
                  }
                  if (lessonSnapshot.hasError || !lessonSnapshot.hasData || lessonSnapshot.data == null) {
                    return CurrentLessonCard(
                      courseTitle: 'Error/No Lesson',
                      lessonTitle: 'Could not load current lesson: ${lessonSnapshot.error}',
                      progress: 0.0,
                      onTap: () { /* Handle error navigation, e.g., back to courses */ },
                    );
                  }

                  final currentLesson = lessonSnapshot.data!;
                  final lessonProgressData = activeProgress.lessonsProgress[currentLesson.id];
                  final double progress = (lessonProgressData != null && lessonProgressData.isCompleted) ? 1.0 : 0.0;

                  return CurrentLessonCard(
                    courseTitle: 'Current Course', // You might want to fetch course title here
                    lessonTitle: currentLesson.title,
                    progress: progress,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRouter.lessonRoute,
                        arguments: {
                          'courseId': activeProgress.courseId,
                          'levelId': activeProgress.currentLevelId!,
                          'lessonId': currentLesson.id,
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: AppConstants.padding * 2),

          Text(
            'My Courses',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.largeTextSize, // Adjusted text size
                ),
          ),
          const SizedBox(height: AppConstants.spacing),
          StreamBuilder<List<Course>>(
            stream: firebaseService.streamAllCoursesForUser(currentUser.uid), // Filter by creatorId
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text('Error loading courses: ${snapshot.error}',
                        style: const TextStyle(color: AppColors.errorColor)));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Column(
                  children: [
                    Text(
                      'You haven\'t created any courses yet. Create one now!',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textColorSecondary,
                        fontSize: AppConstants.mediumTextSize, // Adjusted text size
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.spacing),
                    // Removed the ElevatedButton here, as creation is via bottom nav bar now.
                  ],
                );
              }

              final courses = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
                    child: CourseCard(
                      course: course,
                      onTap: () {
                        // Pass the entire Course object
                        Navigator.of(context).pushNamed(
                          AppRouter.levelSelectionRoute,
                          arguments: course,
                        );
                      },
                      onDelete: (courseId, levelIds) async {
                        final bool confirmDelete = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete Course?', style: TextStyle(fontSize: AppConstants.largeTextSize)), // Text size
                            content: Text('Are you sure you want to delete this course and all its data? This cannot be undone.', style: TextStyle(fontSize: AppConstants.mediumTextSize)), // Text size
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorColor),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ) ?? false;

                        if (confirmDelete) {
                          try {
                            await firebaseService.deleteCourse(courseId, levelIds);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Course "${course.title}" deleted successfully!'),
                                backgroundColor: AppColors.successColor,
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error deleting course: $e'),
                                backgroundColor: AppColors.errorColor,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: AppConstants.padding * 2),
          Text(
            'Explore Public Courses',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.largeTextSize, // Adjusted text size
                ),
          ),
          const SizedBox(height: AppConstants.spacing),
          StreamBuilder<List<Course>>(
            stream: firebaseService.streamPublicCourses(currentUser.uid), // Stream public courses (not created by current user)
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)));
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text('Error loading public courses: ${snapshot.error}',
                        style: const TextStyle(color: AppColors.errorColor)));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text(
                  'No public courses available yet. Be the first to create one!',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textColorSecondary,
                    fontSize: AppConstants.mediumTextSize, // Adjusted text size
                  ),
                  textAlign: TextAlign.center,
                );
              }

              final publicCourses = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: publicCourses.length,
                itemBuilder: (context, index) {
                  final course = publicCourses[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
                    child: CourseCard(
                      course: course,
                      onTap: () {
                        // Pass the entire Course object
                        Navigator.of(context).pushNamed(
                          AppRouter.levelSelectionRoute,
                          arguments: course,
                        );
                      },
                      onDelete: null, // Public courses cannot be deleted by others
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
