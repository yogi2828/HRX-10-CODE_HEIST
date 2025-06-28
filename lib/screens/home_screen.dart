// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/models/course.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/course/course_card.dart';
import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
import 'package:gamifier/widgets/common/xp_level_display.dart';
import 'package:gamifier/widgets/gamification/streak_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProfile? _userProfile;
  late Stream<List<Course>> _coursesStream;
  late FirebaseService _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    _loadUserProfile();
    _coursesStream = _firebaseService.streamAllCourses();
  }

  Future<void> _loadUserProfile() async {
    final user = _firebaseService.currentUser;
    if (user != null) {
      _firebaseService.streamUserProfile(user.uid).listen((profile) {
        if (mounted) {
          setState(() {
            _userProfile = profile;
          });
        }
      }).onError((error) {
        debugPrint('Error loading user profile: $error');
      });
    }
  }

  void _onCourseTapped(Course course) {
    Navigator.of(context).pushNamed(
      AppRouter.levelSelectionRoute,
      arguments: {
        'courseId': course.id,
        'courseTitle': course.title,
      },
    );
  }

  void _deleteCourse(Course course) async {
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.cardColor,
          title: const Text('Delete Course', style: TextStyle(color: AppColors.textColor)),
          content: Text(
            'Are you sure you want to delete "${course.title}"? This action cannot be undone.',
            style: const TextStyle(color: AppColors.textColorSecondary),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel', style: TextStyle(color: AppColors.accentColor)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Delete', style: TextStyle(color: AppColors.errorColor)),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        await _firebaseService.deleteCourse(course.id, course.levelIds);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Course deleted successfully!')),
          );
        }
      } catch (e) {
        debugPrint('Error deleting course: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete course: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        title: AppConstants.appName,
        automaticallyImplyLeading: false, // Home screen is the root, no back button needed.
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConstants.padding),
                child: _userProfile == null
                    ? const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 65, 85, 88)))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: AppConstants.avatarSize / 2,
                                backgroundImage: AssetImage(_userProfile!.avatarAssetPath),
                                backgroundColor: AppColors.borderColor,
                              ),
                              const SizedBox(width: AppConstants.spacing * 2),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello, ${_userProfile!.username}!',
                                      style: AppColors.neonTextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(height: AppConstants.spacing),
                                    XpLevelDisplay(
                                      xp: _userProfile!.xp,
                                      level: _userProfile!.level,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.spacing * 2),
                          StreakDisplay(currentStreak: _userProfile!.currentStreak),
                        ],
                      ),
              ),
              Expanded(
                child: StreamBuilder<List<Course>>(
                  stream: _coursesStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No courses found. Create one to get started!',
                          style: TextStyle(color: AppColors.textColorSecondary, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    final courses = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return CourseCard(
                          course: course,
                          onTap: () => _onCourseTapped(course),
                          onDelete: () => _deleteCourse(course),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}