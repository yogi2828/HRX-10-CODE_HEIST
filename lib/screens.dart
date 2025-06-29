// // lib/widgets/navigation/bottom_nav_bar.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/utils/app_router.dart';

// class BottomNavBar extends StatelessWidget {
//   final int currentIndex;

//   const BottomNavBar({
//     super.key,
//     required this.currentIndex,
//   });

//   void _onItemTapped(BuildContext context, int index) {
//     // Determine if we should replace the current route or push a new one
//     // Course Creation (index 4) should push, allowing back navigation to the previous main screen.
//     // Other main screens (Home, Progress, Community, AI Tutor, Profile) should replace to avoid deep navigation stacks.
//     if (index == currentIndex) return; // Prevent navigating to the same route again

//     switch (index) {
//       case 0:
//         Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
//         break;
//       case 1:
//         Navigator.of(context).pushReplacementNamed(AppRouter.progressRoute);
//         break;
//       case 2:
//         Navigator.of(context).pushReplacementNamed(AppRouter.communityRoute);
//         break;
//       case 3:
//         Navigator.of(context).pushReplacementNamed(AppRouter.chatRoute);
//         break;
//       case 4: // Create Course
//         // Use pushNamed to allow navigating back to the previous main tab
//         Navigator.of(context).pushNamed(AppRouter.courseCreationRoute);
//         break;
//       case 5:
//         Navigator.of(context).pushReplacementNamed(AppRouter.profileRoute);
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: (index) => _onItemTapped(context, index),
//       backgroundColor: AppColors.primaryColorDark.withOpacity(0.9),
//       selectedItemColor: AppColors.accentColor,
//       unselectedItemColor: AppColors.textColorSecondary,
//       type: BottomNavigationBarType.fixed,
//       selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//       unselectedLabelStyle: const TextStyle(fontSize: 11),
//       elevation: 8,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Progress',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Community',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'AI Tutor',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Create Course',
//         ),
//         BottomNavigationBarItem(
//           icon: SizedBox.shrink(), // Replaced Icon with an empty SizedBox
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }
// // lib/screens/progress_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/progress_bar.dart';
// import 'package:gamifier/widgets/gamification/leaderboard_list.dart'; // Import LeaderboardList

// class ProgressScreen extends StatefulWidget {
//   const ProgressScreen({super.key});

//   @override
//   State<ProgressScreen> createState() => _ProgressScreenState();
// }

// class _ProgressScreenState extends State<ProgressScreen> with SingleTickerProviderStateMixin {
//   late FirebaseService _firebaseService;
//   String? _currentUserId;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     _tabController = TabController(length: 2, vsync: this);
//     _initializeUserAndLoadProgress();
//   }

//   Future<void> _initializeUserAndLoadProgress() async {
//     final user = _firebaseService.currentUser;
//     if (user != null) {
//       setState(() {
//         _currentUserId = user.uid;
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _errorMessage = 'User not logged in.';
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: Text('My Progress'),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: AppColors.accentColor,
//           labelColor: AppColors.accentColor,
//           unselectedLabelColor: AppColors.textColorSecondary,
//           tabs: const [
//             Tab(text: 'My Progress', icon: Icon(Icons.show_chart)),
//             Tab(text: 'Leaderboard', icon: Icon(Icons.leaderboard)),
//           ],
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: _isLoading
//               ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//               : _errorMessage != null
//                   ? Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(AppConstants.padding),
//                         child: Text(
//                           _errorMessage!,
//                           style: const TextStyle(color: AppColors.errorColor),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     )
//                   : TabBarView(
//                       controller: _tabController,
//                       children: [
//                         // My Progress Tab
//                         SingleChildScrollView(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Your Course Progress',
//                                 style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.accentColor),
//                               ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               StreamBuilder<List<Course>>(
//                                 stream: _firebaseService.streamAllCourses(),
//                                 builder: (context, courseSnapshot) {
//                                   if (courseSnapshot.connectionState == ConnectionState.waiting) {
//                                     return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
//                                   }
//                                   if (courseSnapshot.hasError) {
//                                     return Center(child: Text('Error loading courses: ${courseSnapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//                                   }
//                                   if (!courseSnapshot.hasData || courseSnapshot.data!.isEmpty) {
//                                     return const Center(
//                                       child: Text(
//                                         'No courses available to track progress. Create one to get started!',
//                                         style: TextStyle(color: AppColors.textColorSecondary),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     );
//                                   }

//                                   final courses = courseSnapshot.data!;

//                                   return ListView.builder(
//                                     shrinkWrap: true, // Important for ListView inside SingleChildScrollView
//                                     physics: const NeverScrollableScrollPhysics(), // Important to prevent nested scrolling
//                                     itemCount: courses.length,
//                                     itemBuilder: (context, index) {
//                                       final course = courses[index];
//                                       return StreamBuilder<UserProgress?>(
//                                         stream: _firebaseService.streamUserCourseProgress(_currentUserId!, course.id),
//                                         builder: (context, progressSnapshot) {
//                                           if (progressSnapshot.connectionState == ConnectionState.waiting) {
//                                             return CourseProgressCard(course: course, progressPercentage: 0, lessonsCompleted: 0, totalLessons: 0, totalXpEarned: 0, isLoading: true);
//                                           }
//                                           if (progressSnapshot.hasError) {
//                                             return CourseProgressCard(course: course, progressPercentage: 0, lessonsCompleted: 0, totalLessons: 0, totalXpEarned: 0, isError: true);
//                                           }

//                                           final userProgress = progressSnapshot.data;

//                                           int totalLevelsInCourse = course.levelIds.length;
//                                           int completedLevelsCount = 0;
//                                           int totalXpEarned = 0;

//                                           if (userProgress != null) {
//                                             completedLevelsCount = userProgress.levelsProgress.values.where((p) => p.isCompleted).length;
//                                             totalXpEarned = userProgress.levelsProgress.values.fold(0, (sum, progress) => sum + progress.xpEarned);
//                                           }

//                                           double progressPercentage = totalLevelsInCourse > 0
//                                               ? (completedLevelsCount / totalLevelsInCourse)
//                                               : 0.0;

//                                           return CourseProgressCard(
//                                             course: course,
//                                             progressPercentage: progressPercentage,
//                                             lessonsCompleted: completedLevelsCount, // Display completed levels for course
//                                             totalLessons: totalLevelsInCourse, // Display total levels for course
//                                             totalXpEarned: totalXpEarned,
//                                           );
//                                         },
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                             ],
//                           ),
//                         ),
//                         // Leaderboard Tab
//                         SingleChildScrollView(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Global Leaderboard',
//                                 style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.xpColor),
//                               ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               const LeaderboardList(), // Integrate the LeaderboardList widget
//                               const SizedBox(height: AppConstants.spacing * 2),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 1),
//     );
//   }
// }

// class CourseProgressCard extends StatelessWidget {
//   final Course course;
//   final double progressPercentage;
//   final int lessonsCompleted; // Now represents completed levels
//   final int totalLessons;     // Now represents total levels
//   final int totalXpEarned;
//   final bool isLoading;
//   final bool isError;

//   const CourseProgressCard({
//     super.key,
//     required this.course,
//     required this.progressPercentage,
//     required this.lessonsCompleted,
//     required this.totalLessons,
//     required this.totalXpEarned,
//     this.isLoading = false,
//     this.isError = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//       color: AppColors.cardColor.withOpacity(0.8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//       ),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.padding),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//             : isError
//                 ? const Center(child: Text('Error loading progress', style: TextStyle(color: AppColors.errorColor)))
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         course.title,
//                         style: const TextStyle(
//                           color: AppColors.textColor,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       Text(
//                         course.description,
//                         style: const TextStyle(
//                           color: AppColors.textColorSecondary,
//                           fontSize: 14,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: AppConstants.spacing * 2),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Progress: ${(progressPercentage * 100).toStringAsFixed(0)}%',
//                             style: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             'XP: $totalXpEarned',
//                             style: const TextStyle(color: AppColors.xpColor, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       ProgressBar(
//                         current: (progressPercentage * 100).round(),
//                         total: 100,
//                         backgroundColor: AppColors.progressTrackColor,
//                         progressColor: AppColors.accentColor,
//                       ),
//                       const SizedBox(height: AppConstants.spacing),
//                       Text(
//                         'Levels Completed: ${lessonsCompleted}/${totalLessons}', // Display levels
//                         style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 12),
//                       ),
//                     ],
//                   ),
//       ),
//     );
//   }
// }
// // lib/screens/profile_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/gamification/badge_display.dart';
// import 'package:gamifier/widgets/common/xp_level_display.dart';
// import 'package:gamifier/widgets/gamification/streak_display.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   UserProfile? _userProfile;
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final user = firebaseService.currentUser;

//     if (user != null) {
//       firebaseService.streamUserProfile(user.uid).listen((profile) {
//         if (mounted) {
//           setState(() {
//             _userProfile = profile;
//             _isLoading = false;
//           });
//         }
//       }).onError((error) {
//         debugPrint('Error streaming user profile: $error');
//         if (mounted) {
//           setState(() {
//             _errorMessage = 'Failed to load profile: ${error.toString()}';
//             _isLoading = false;
//           });
//         }
//       });
//     } else {
//       setState(() {
//         _errorMessage = 'User not logged in.';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _signOut() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       await Provider.of<FirebaseService>(context, listen: false).signOut();
//       if (mounted) {
//         Navigator.of(context).pushReplacementNamed(AppRouter.authRoute);
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error signing out: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'My Profile'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: _isLoading
//               ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//               : _errorMessage != null
//                   ? Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(AppConstants.padding),
//                         child: Text(
//                           _errorMessage!,
//                           style: const TextStyle(color: AppColors.errorColor),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     )
//                   : _userProfile == null
//                       ? const Center(
//                           child: Text(
//                             'User profile not found. Please log in again.',
//                             style: TextStyle(color: AppColors.textColorSecondary),
//                           ),
//                         )
//                       : SingleChildScrollView(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Center(
//                                 child: Stack(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: AppConstants.avatarSize,
//                                       backgroundImage: AssetImage(_userProfile!.avatarAssetPath),
//                                       backgroundColor: AppColors.borderColor,
//                                     ),
//                                     Positioned(
//                                       bottom: 0,
//                                       right: 0,
//                                       child: IconButton(
//                                         icon: const Icon(Icons.edit, color: AppColors.accentColor),
//                                         onPressed: () {
//                                           Navigator.of(context).pushNamed(AppRouter.avatarCustomizerRoute);
//                                         },
//                                         tooltip: 'Customize Avatar',
//                                         style: IconButton.styleFrom(
//                                           backgroundColor: AppColors.primaryColor,
//                                           shape: const CircleBorder(),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               Text(
//                                 _userProfile!.username,
//                                 style: AppColors.neonTextStyle(fontSize: 28),
//                                 textAlign: TextAlign.center,
//                               ),
//                               if (_userProfile!.email.isNotEmpty) ...[
//                                 const SizedBox(height: AppConstants.spacing),
//                                 Text(
//                                   _userProfile!.email,
//                                   style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                               const SizedBox(height: AppConstants.spacing * 3),
//                               XpLevelDisplay(xp: _userProfile!.xp, level: _userProfile!.level),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               StreakDisplay(currentStreak: _userProfile!.currentStreak),
//                               const SizedBox(height: AppConstants.spacing * 3),
//                               if (_userProfile!.educationLevel != null && _userProfile!.educationLevel!.isNotEmpty)
//                                 Card(
//                                   color: AppColors.cardColor.withOpacity(0.8),
//                                   margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(AppConstants.padding),
//                                     child: Row(
//                                       children: [
//                                         const Icon(Icons.school, color: AppColors.secondaryColor),
//                                         const SizedBox(width: AppConstants.spacing),
//                                         Text(
//                                           'Education Level: ${_userProfile!.educationLevel}',
//                                           style: const TextStyle(color: AppColors.textColor, fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               if (_userProfile!.specialty != null && _userProfile!.specialty!.isNotEmpty)
//                                 Card(
//                                   color: AppColors.cardColor.withOpacity(0.8),
//                                   margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(AppConstants.padding),
//                                     child: Row(
//                                       children: [
//                                         const Icon(Icons.star, color: AppColors.xpColor),
//                                         const SizedBox(width: AppConstants.spacing),
//                                         Text(
//                                           'Specialty: ${_userProfile!.specialty}',
//                                           style: const TextStyle(color: AppColors.textColor, fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               const SizedBox(height: AppConstants.spacing * 2),
//                               Text(
//                                 'Badges Earned (${_userProfile!.earnedBadges.length})',
//                                 style: AppColors.neonTextStyle(fontSize: 20, color: AppColors.secondaryColor),
//                               ),
//                               const SizedBox(height: AppConstants.spacing),
//                               _userProfile!.earnedBadges.isEmpty
//                                   ? const Text(
//                                       'No badges earned yet. Keep learning!',
//                                       style: TextStyle(color: AppColors.textColorSecondary),
//                                     )
//                                   : BadgeDisplay(badgeIds: _userProfile!.earnedBadges),
//                               const SizedBox(height: AppConstants.spacing * 4),
//                               CustomButton(
//                                 onPressed: _signOut,
//                                 text: 'Sign Out',
//                                 icon: Icons.logout,
//                                 isLoading: _isLoading,
//                               ),
//                             ],
//                           ),
//                         ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 5),
//     );
    
//   }
// }
// // lib/screens/level_selection_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/screens/lesson_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart'; // Import Course model
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/lesson.dart'; // Import Lesson model
// import 'package:gamifier/models/question.dart'; // Import Question model
// import 'package:gamifier/models/user_profile.dart'; // Import UserProfile model
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/gamification/level_node.dart';
// import 'package:gamifier/widgets/gamification/level_path_painter.dart';
// import 'dart:math'; // Import for max
// import 'package:collection/collection.dart'; // Import for firstWhereOrNull

// class LevelSelectionScreen extends StatefulWidget {
//   final String courseId;
//   final String courseTitle;

//   const LevelSelectionScreen({
//     super.key,
//     required this.courseId,
//     required this.courseTitle,
//   });

//   @override
//   State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
// }

// class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
//   late Stream<List<Level>> _levelsStream;
//   late Stream<UserProgress?> _userProgressStream;
//   UserProfile? _currentUserProfile;
//   List<Level> _levels = [];
//   bool _isLoadingMoreLevels = false;
//   String? _errorMessage;
//   final Map<String, Offset> _levelNodePositions = {}; // To store calculated top-left positions

//   // A key to access the render box of a specific level node
//   final Map<String, GlobalKey> _levelKeys = {};

//   @override
//   void initState() {
//     super.initState();
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser != null) {
//       _levelsStream = firebaseService.streamLevelsForCourse(widget.courseId);
//       _levelsStream.listen((levels) {
//         if (mounted) {
//           setState(() {
//             _levels = levels;
//             // Initialize GlobalKeys for new levels
//             for (var level in levels) {
//               if (!_levelKeys.containsKey(level.id)) {
//                 _levelKeys[level.id] = GlobalKey();
//               }
//             }
//             // Recalculate positions after the levels data is updated
//             // Do this in a post-frame callback to ensure widgets are rendered and have sizes
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _calculateLevelNodePositions();
//             });
//           });
//         }
//       }).onError((e) {
//         debugPrint('Error streaming levels: $e');
//         if (mounted) {
//           setState(() {
//             _errorMessage = 'Failed to load levels: ${e.toString()}';
//           });
//         }
//       });

//       _userProgressStream = firebaseService.streamUserCourseProgress(currentUser.uid, widget.courseId);
//       _userProgressStream.listen((progress) {
//         if (mounted && progress != null) {
//           debugPrint('User Progress Updated: ${progress.currentLevelId}');
//           // Trigger recalculation if progress affects level unlock status
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _calculateLevelNodePositions(); // Re-render paths based on completion status
//           });
//         }
//       }).onError((e) {
//         debugPrint('Error streaming user progress: $e');
//       });

//       firebaseService.streamUserProfile(currentUser.uid).listen((profile) {
//         if (mounted) {
//           setState(() {
//             _currentUserProfile = profile;
//           });
//         }
//       });
//     } else {
//       _errorMessage = 'User not logged in. Please log in to view courses.';
//     }
//   }

//   // Calculate positions for zigzag layout using a Stack
//   void _calculateLevelNodePositions() {
//     _levelNodePositions.clear();
//     const double nodeSize = 120.0; // Width/Height of LevelNode
//     const double verticalStep = 160.0; // Vertical distance between centers of nodes (increased for more space)

//     final double screenWidth = MediaQuery.of(context).size.width;
//     // Adjusted these to better center the columns for any screen size
//     final double leftColumnX = screenWidth * 0.2 - nodeSize / 2;
//     final double rightColumnX = screenWidth * 0.8 - nodeSize / 2;

//     for (int i = 0; i < _levels.length; i++) {
//       final level = _levels[i];
//       double x;
//       double y = (i * verticalStep) + AppConstants.padding * 2; // Add top padding to start layout lower

//       if (i % 2 == 0) {
//         // Even index (0, 2, 4...), aligned to the left side
//         x = leftColumnX;
//       } else {
//         // Odd index (1, 3, 5...), aligned to the right side
//         x = rightColumnX;
//       }
//       _levelNodePositions[level.id] = Offset(x, y);
//     }

//     // Recalculate positions for the "Generate More Levels" button
//     if (_levels.length < AppConstants.maxLevelsPerCourse) {
//       final double lastNodeY = _levels.isNotEmpty
//           ? _levelNodePositions[_levels.last.id]!.dy + verticalStep
//           : AppConstants.padding * 2; // Position below the last node or initial padding
//       final double centerX = screenWidth / 2 - nodeSize / 2; // Center the button
//       _levelNodePositions['generate_more'] = Offset(centerX, lastNodeY);
//     }
//   }


//   Future<void> _loadMoreLevels() async {
//     if (_isLoadingMoreLevels || _levels.length >= AppConstants.maxLevelsPerCourse) {
//       return;
//     }

//     setState(() {
//       _isLoadingMoreLevels = true;
//       _errorMessage = null;
//     });

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final geminiService = Provider.of<GeminiApiService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;
//     final userProfile = await firebaseService.getUserProfile(currentUser!.uid);


//     if (currentUser == null || userProfile == null) {
//       setState(() {
//         _errorMessage = 'User not logged in or profile not found.';
//         _isLoadingMoreLevels = false;
//       });
//       return;
//     }

//     try {
//       final int nextStartingOrder = _levels.isNotEmpty ? _levels.last.order + 1 : 1;
//       final int levelsToGenerate = (AppConstants.maxLevelsPerCourse - _levels.length).clamp(0, AppConstants.subsequentLevelsBatchSize);

//       if (levelsToGenerate <= 0) {
//         setState(() {
//           _isLoadingMoreLevels = false;
//         });
//         return;
//       }

//       final List<Level> previousLevelsContext = _levels.sublist(
//           _levels.length > 5 ? _levels.length - 5 : 0); // Provide last few levels for context

//       final Map<String, dynamic> generatedData = await geminiService.generateSubsequentLevels(
//         courseId: widget.courseId,
//         topicName: widget.courseTitle,
//         ageGroup: 'college student',
//         domain: 'General Education',
//         difficulty: 'Intermediate',
//         language: userProfile.language ?? AppConstants.supportedLanguages.first, // Use user's preferred language or default
//         startingLevelOrder: nextStartingOrder,
//         numberOfLevels: levelsToGenerate,
//         educationLevel: userProfile.educationLevel,
//         specialty: userProfile.specialty,
//       );

//       List<Level> newLevels = (generatedData['levels'] as List).map((e) => Level.fromMap(e as Map<String, dynamic>)).toList();
//       Map<String, List<Lesson>> lessonsPerLevel = {};
//       (generatedData['lessonsPerLevel'] as Map).forEach((key, value) {
//         lessonsPerLevel[key as String] = (value as List).map((e) => Lesson.fromMap(e as Map<String, dynamic>)).toList();
//       });

//       Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};
//       (generatedData['questionsPerLessonPerLevel'] as Map).forEach((levelId, lessonMap) {
//         questionsPerLessonPerLevel[levelId as String] = {};
//         (lessonMap as Map).forEach((lessonId, questionList) {
//           questionsPerLessonPerLevel[levelId]![lessonId as String] = (questionList as List).map((e) => Question.fromMap(e as Map<String, dynamic>)).toList();
//         });
//       });


//       await firebaseService.saveLevels(newLevels, lessonsPerLevel, questionsPerLessonPerLevel);

//       // Update the course with new level IDs
//       final Course? existingCourse = await firebaseService.getCourse(widget.courseId);
//       if (existingCourse != null) {
//         final updatedCourse = existingCourse.copyWith(
//           levelIds: [...?existingCourse.levelIds, ...newLevels.map((l) => l.id).toList()],
//         );
//         await firebaseService.updateCourse(widget.courseId, {'levelIds': updatedCourse.levelIds});
//       }

//       if (mounted) {
//         setState(() {
//           _levels.addAll(newLevels);
//           // Initialize GlobalKeys for newly added levels
//           for (var level in newLevels) {
//             _levelKeys[level.id] = GlobalKey();
//           }
//           _calculateLevelNodePositions(); // Recalculate positions after adding new levels
//         });
//       }
//     } catch (e) {
//       debugPrint('Error generating more levels: $e');
//       if (mounted) {
//         setState(() {
//           _errorMessage = 'Failed to generate more levels: ${e.toString()}';
//         });
//       }
//     } finally {
//       setState(() {
//         _isLoadingMoreLevels = false;
//       });
//     }
//   }

//   void _onLevelTapped(Level level, UserProgress? userProgress) async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please log in to start a lesson.')),
//       );
//       return;
//     }

//     // Determine if the level is currently locked.
//     // A level is locked if it's not the first level AND the previous level is not completed.
//     final bool isPreviousLevelCompleted = level.order == 1 ||
//         _levels.any((l) => l.order == level.order - 1 && (userProgress?.levelsProgress[l.id]?.isCompleted == true));

//     final bool isLocked = !isPreviousLevelCompleted && level.order != 1;


//     if (isLocked) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('This level is locked! Complete previous levels first.')),
//       );
//       return;
//     }

//     try {
//       // Fetch the most up-to-date user progress
//       UserProgress? latestUserProgress = await firebaseService.getUserCourseProgress(currentUser.uid, widget.courseId);
//       Lesson? lessonToStart;

//       // Determine which lesson to start within the level
//       List<Lesson> allLessonsInLevel = await firebaseService.getFirestore()
//           .collection(AppConstants.levelsCollection)
//           .doc(level.id)
//           .collection('lessons')
//           .orderBy('order')
//           .get()
//           .then((snapshot) => snapshot.docs.map((doc) => Lesson.fromMap(doc.data())).toList());

//       if (allLessonsInLevel.isEmpty) {
//         debugPrint('No lessons found for level ${level.id}.');
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('No lessons available for this level. Please try another course.')),
//           );
//         }
//         return;
//       }

//       if (latestUserProgress != null &&
//           latestUserProgress.currentLevelId == level.id &&
//           latestUserProgress.currentLessonId != null) {
//         // User is continuing this level, try to load current lesson
//         lessonToStart = allLessonsInLevel.firstWhereOrNull(
//               (lesson) => lesson.id == latestUserProgress.currentLessonId,
//         );

//         // If current lesson is completed or not found, try to find the next uncompleted lesson
//         if (lessonToStart == null || (latestUserProgress.lessonsProgress[lessonToStart.id]?.isCompleted == true)) {
//           lessonToStart = allLessonsInLevel.firstWhereOrNull(
//                 (lesson) => !(latestUserProgress?.lessonsProgress[lesson.id]?.isCompleted == true),
//           );
//         }
//       }

//       if (lessonToStart == null) {
//         // If no progress, or no next uncompleted lesson found, start from the first lesson of the level
//         lessonToStart = allLessonsInLevel.first;
//       }

//       if (lessonToStart != null) {
//         // Update user progress to reflect the current level and lesson
//         final String progressId = '${currentUser.uid}_${widget.courseId}';
//         final updatedUserProgress = (latestUserProgress ?? UserProgress(
//           id: progressId,
//           userId: currentUser.uid,
//           courseId: widget.courseId,
//           currentLevelId: level.id,
//           currentLessonId: lessonToStart.id,
//         )).copyWith(
//           currentLevelId: level.id,
//           currentLessonId: lessonToStart.id,
//           levelsProgress: Map.from(latestUserProgress?.levelsProgress ?? {})..putIfAbsent(level.id, () => const LevelProgress(isCompleted: false, xpEarned: 0, score: 0)),
//           lessonsProgress: Map.from(latestUserProgress?.lessonsProgress ?? {})..putIfAbsent(lessonToStart.id, () => const LessonProgress(isCompleted: false, xpEarned: 0, questionAttempts: {})),
//         );
//         await firebaseService.saveUserProgress(updatedUserProgress);

//         if (mounted) {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => LessonScreen(
//                 courseId: widget.courseId,
//                 levelId: level.id,
//                 lessonId: lessonToStart!.id,
//                 levelOrder: level.order,
//               ),
//             ),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to load lesson details. Please try again.')),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error navigating to lesson: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load lesson: ${e.toString()}')),
//       );
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: CustomAppBar(
//         title: widget.courseTitle,
//         automaticallyImplyLeading: true, // Show back arrow
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: StreamBuilder<UserProgress?>(
//             stream: _userProgressStream,
//             builder: (context, progressSnapshot) {
//               final userProgress = progressSnapshot.data;

//               // Calculate the total height needed for the scrollable content
//               // This accounts for all level nodes and the "Generate More Levels" button
//               final double contentHeight = (_levels.length * 160.0) + // Vertical step per level
//                   (AppConstants.padding * 4) + // Initial/final padding
//                   (AppConstants.levelSelectionGenerateButtonHeight); // Height for the button area

//               return SingleChildScrollView(
//                 child: SizedBox(
//                   // Ensure the SizedBox has enough height to allow scrolling if content exceeds screen height
//                   height: max(contentHeight, MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top),
//                   width: MediaQuery.of(context).size.width, // Ensure it takes full width for painting
//                   child: Stack(
//                     children: [
//                       // Draw zigzag lines
//                       if (_levels.isNotEmpty && _levelNodePositions.isNotEmpty)
//                         CustomPaint(
//                           painter: LevelPathPainter(
//                             levels: _levels,
//                             levelPositions: _levelNodePositions,
//                             levelCompletionStatus: {
//                               for (var level in _levels)
//                                 level.id: userProgress?.levelsProgress[level.id]?.isCompleted == true,
//                             },
//                             nodeSize: 120.0, // Pass node size for path calculation
//                           ),
//                           child: Container(), // Empty container to provide paint area
//                         ),

//                       // Position LevelNodes
//                       ..._levels.map((level) {
//                         final int currentLevelIndex = _levels.indexOf(level);
//                         final String? previousLevelId = currentLevelIndex > 0 ? _levels[currentLevelIndex - 1].id : null;
//                         final bool isPreviousLevelCompleted = previousLevelId != null && (userProgress?.levelsProgress[previousLevelId]?.isCompleted == true);

//                         final bool isLocked = level.order > 1 && !isPreviousLevelCompleted;

//                         final Offset? position = _levelNodePositions[level.id];
//                         if (position == null) return const SizedBox.shrink();

//                         return Positioned(
//                           left: position.dx,
//                           top: position.dy,
//                           child: LevelNode(
//                             key: _levelKeys[level.id], // Assign GlobalKey
//                             level: level,
//                             isCompleted: userProgress?.levelsProgress[level.id]?.isCompleted == true, // Explicitly check completion status from userProgress
//                             isLocked: isLocked,
//                             onTap: () => _onLevelTapped(level, userProgress),
//                           ),
//                         );
//                       }).toList(),

//                       // Position "Generate More Levels" button
//                       if (_levels.length < AppConstants.maxLevelsPerCourse)
//                         Positioned(
//                           left: _levelNodePositions['generate_more']?.dx,
//                           top: _levelNodePositions['generate_more']?.dy,
//                           child: GestureDetector(
//                             onTap: _isLoadingMoreLevels ? null : _loadMoreLevels,
//                             child: Card(
//                               color: AppColors.cardColor.withOpacity(0.7),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                                 side: BorderSide(color: AppColors.borderColor.withOpacity(0.5), width: 1),
//                               ),
//                               child: Container(
//                                 width: 120, // Match node size
//                                 height: 120, // Match node size
//                                 padding: const EdgeInsets.all(AppConstants.padding),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     _isLoadingMoreLevels
//                                         ? const CircularProgressIndicator(color: AppColors.accentColor)
//                                         : Icon(
//                                             Icons.add_circle_outline,
//                                             color: AppColors.textColorSecondary.withOpacity(0.7),
//                                             size: 50,
//                                           ),
//                                     const SizedBox(height: AppConstants.spacing),
//                                     Text(
//                                       _isLoadingMoreLevels ? 'Generating...' : 'Generate More Levels',
//                                       style: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.9), fontSize: 12), // Smaller font
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     if (_errorMessage != null)
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: AppConstants.spacing),
//                                         child: Text(
//                                           _errorMessage!,
//                                           style: const TextStyle(color: AppColors.errorColor, fontSize: 10),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/level_completion_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/audio_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/xp_level_display.dart';
// import 'package:gamifier/screens/level_selection_screen.dart'; // Import LevelSelectionScreen
// import 'package:gamifier/screens/home_screen.dart'; // Import HomeScreen

// class LevelCompletionScreen extends StatefulWidget {
//   final String courseId;
//   final String levelId;
//   final int xpEarned;
//   final bool isCourseCompleted;

//   const LevelCompletionScreen({
//     super.key,
//     required this.courseId,
//     required this.levelId,
//     required this.xpEarned,
//     this.isCourseCompleted = false,
//   });

//   @override
//   State<LevelCompletionScreen> createState() => _LevelCompletionScreenState();
// }

// class _LevelCompletionScreenState extends State<LevelCompletionScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   late AudioService _audioService;
//   int _currentXp = 0;
//   int _currentLevel = 0;

//   @override
//   void initState() {
//     super.initState();
//     _audioService = Provider.of<AudioService>(context, listen: false);
//     _audioService.playLevelUpSound();
//     _loadUserProfile(); // Load user profile to display updated XP and Level

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );

//     _controller.forward();
//   }

//   Future<void> _loadUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final user = firebaseService.currentUser;
//     if (user != null) {
//       // Use a stream to react to real-time updates of XP/level
//       firebaseService.streamUserProfile(user.uid).listen((profile) {
//         if (mounted && profile != null) {
//           setState(() {
//             _currentXp = profile.xp;
//             _currentLevel = profile.level;
//           });
//         }
//       }).onError((error) {
//         debugPrint('Error streaming user profile in LevelCompletionScreen: $error');
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(AppConstants.padding * 2),
//             child: ScaleTransition(
//               scale: _scaleAnimation,
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: Card(
//                   color: AppColors.cardColor.withOpacity(0.9),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
//                     side: const BorderSide(color: AppColors.accentColor, width: 2),
//                   ),
//                   elevation: 10,
//                   child: Padding(
//                     padding: const EdgeInsets.all(AppConstants.padding * 2),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           Icons.check_circle_outline,
//                           color: AppColors.successColor,
//                           size: 80,
//                         ),
//                         const SizedBox(height: AppConstants.spacing * 2),
//                         Text(
//                           widget.isCourseCompleted ? 'Course Completed!' : 'Level Completed!',
//                           style: AppColors.neonTextStyle(fontSize: 28, color: AppColors.accentColor),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: AppConstants.spacing),
//                         Text(
//                           'You earned ${widget.xpEarned} XP!',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.xpColor,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: AppConstants.spacing * 2),
//                         XpLevelDisplay(xp: _currentXp, level: _currentLevel),
//                         const SizedBox(height: AppConstants.spacing * 4),
//                         CustomButton(
//                           onPressed: () {
//                             if (widget.isCourseCompleted) {
//                               // If course is completed, go back to the Home screen and remove all other routes
//                               Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(builder: (context) => const HomeScreen()),
//                                 (route) => false, // Remove all routes
//                               );
//                             } else {
//                               // If course is NOT completed, go back to the Level Selection for this course
//                               // Remove all routes until the home route, then push LevelSelectionScreen
//                               // This handles cases where LessonScreen might be pushed directly.
//                               Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(
//                                   builder: (context) => LevelSelectionScreen(
//                                     courseId: widget.courseId,
//                                     courseTitle: '', // Title not strictly needed for navigation, but required by constructor
//                                   ),
//                                 ),
//                                 (route) => route.settings.name == AppRouter.homeRoute || route.isFirst,
//                               );
//                             }
//                           },
//                           text: widget.isCourseCompleted ? 'Back to Courses' : 'Continue Learning',
//                           icon: widget.isCourseCompleted ? Icons.menu_book : Icons.play_arrow,
//                         ),
//                         const SizedBox(height: AppConstants.spacing),
//                         CustomButton(
//                           onPressed: () {
//                             // Navigate directly to Home and clear all routes below it
//                             Navigator.of(context).pushAndRemoveUntil(
//                               MaterialPageRoute(builder: (context) => const HomeScreen()),
//                               (route) => false, // Remove all routes
//                             );
//                           },
//                           text: 'Go to Home',
//                           icon: Icons.home,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // lib/screens/lesson_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/models/user_progress.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/audio_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/utils/validation_utils.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/progress_bar.dart';
// import 'package:gamifier/widgets/feedback/personalized_feedback_modal.dart';
// import 'package:gamifier/widgets/lesson/lesson_content_display.dart';
// import 'package:gamifier/widgets/questions/question_renderer.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart'; // Import BottomNavBar

// class LessonScreen extends StatefulWidget {
//   final String courseId;
//   final String levelId;
//   final String lessonId;
//   final int levelOrder;

//   const LessonScreen({
//     super.key,
//     required this.courseId,
//     required this.levelId,
//     required this.lessonId,
//     required this.levelOrder,
//   });

//   @override
//   State<LessonScreen> createState() => _LessonScreenState();
// }

// class _LessonScreenState extends State<LessonScreen> {
//   Lesson? _currentLesson;
//   Level? _currentLevel;
//   List<Question> _questions = [];
//   UserProgress? _userProgress;
//   int _currentQuestionIndex = 0;
//   bool _isLoading = true;
//   String? _errorMessage;
//   Map<String, String> _userAnswers = {};
//   Map<String, bool> _questionAttemptStatus = {};
//   Map<String, int> _xpAwardedPerQuestion = {};

//   late FirebaseService _firebaseService;
//   late AudioService _audioService;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     _audioService = Provider.of<AudioService>(context, listen: false);
//     _loadLessonAndProgress();
//   }

//   Future<void> _loadLessonAndProgress() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final user = _firebaseService.currentUser;
//       if (user == null) {
//         setState(() {
//           _errorMessage = 'User not logged in.';
//           _isLoading = false;
//         });
//         return;
//       }

//       final lesson = await _firebaseService.getLesson(widget.levelId, widget.lessonId);
//       final level = await _firebaseService.getLevel(widget.levelId);
//       final questions = await _firebaseService.getLessonQuestions(widget.levelId, widget.lessonId);
//       final userProgress = await _firebaseService.getUserCourseProgress(user.uid, widget.courseId);

//       if (lesson == null || level == null) {
//         setState(() {
//           _errorMessage = 'Lesson or Level not found. Please go back and try again.';
//           _isLoading = false;
//         });
//         return;
//       }

//       setState(() {
//         _currentLesson = lesson;
//         _currentLevel = level;
//         _questions = questions;
//         _userProgress = userProgress ?? UserProgress(
//           id: '${user.uid}_${widget.courseId}',
//           userId: user.uid,
//           courseId: widget.courseId,
//           currentLevelId: widget.levelId,
//           currentLessonId: widget.lessonId,
//         );

//         // Restore user answers and question attempt status if available in progress
//         final lessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id];
//         if (lessonProgress != null) {
//           _currentQuestionIndex = lessonProgress.questionAttempts.length;
//           lessonProgress.questionAttempts.forEach((questionId, attempt) {
//             _questionAttemptStatus[questionId] = attempt.isCorrect;
//             _userAnswers[questionId] = attempt.userAnswer;
//             _xpAwardedPerQuestion[questionId] = attempt.xpAwarded;
//           });
//         }
//         _isLoading = false;
//       });
//     } catch (e) {
//       debugPrint('Error loading lesson or progress: $e');
//       setState(() {
//         _errorMessage = 'Failed to load lesson content: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _submitAnswer(String questionId, String userAnswer, String questionType, dynamic correctAnswerData) async {
//     if (_isLoading) return;
//     setState(() {
//       _isLoading = true;
//     });

//     final firebaseUser = _firebaseService.currentUser;
//     if (firebaseUser == null || _currentLesson == null || _userProgress == null) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = 'User not logged in or lesson/progress data missing.';
//       });
//       return;
//     }

//     // Ensure correctAnswerData is a String for validation, defaulting to empty if null
//     // Specifically handle MCQ where correctAnswer is the correct option string
//     String validationCorrectAnswer;
//     if (questionType == 'MCQ') {
//       // For MCQ, correctAnswerData should directly be the correct answer string from the Question model
//       validationCorrectAnswer = _questions.firstWhere((q) => q.id == questionId).correctAnswer ?? '';
//     } else {
//       validationCorrectAnswer = correctAnswerData?.toString() ?? '';
//     }


//     final bool isCorrect = ValidationUtils.validateAnswer(userAnswer, questionType, validationCorrectAnswer);
//     final int xpAwarded = isCorrect ? _questions[_currentQuestionIndex].xpReward : 0;

//     // Only play correct sound if the answer is correct
//     if (isCorrect) {
//       _audioService.playCorrectSound();
//     }

//     setState(() {
//       _userAnswers[questionId] = userAnswer;
//       _questionAttemptStatus[questionId] = isCorrect;
//       _xpAwardedPerQuestion[questionId] = xpAwarded;
//     });

//     // Update user progress
//     LessonProgress currentLessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id] ??
//         const LessonProgress(isCompleted: false, xpEarned: 0, questionAttempts: {});

//     final updatedQuestionAttempts = Map<String, QuestionAttempt>.from(currentLessonProgress.questionAttempts);
//     updatedQuestionAttempts[questionId] = QuestionAttempt(
//       userAnswer: userAnswer,
//       isCorrect: isCorrect,
//       attemptedAt: DateTime.now(),
//       xpAwarded: xpAwarded,
//     );

//     currentLessonProgress = currentLessonProgress.copyWith(
//       xpEarned: (currentLessonProgress.xpEarned) + xpAwarded, // Correctly accumulate XP
//       questionAttempts: updatedQuestionAttempts,
//     );

//     Map<String, LessonProgress> updatedLessonsProgress = Map.from(_userProgress!.lessonsProgress);
//     updatedLessonsProgress[_currentLesson!.id] = currentLessonProgress;

//     await _firebaseService.addXp(firebaseUser.uid, xpAwarded);

//     _userProgress = _userProgress!.copyWith(
//       lessonsProgress: updatedLessonsProgress,
//     );
//     await _firebaseService.saveUserProgress(_userProgress!);

//     setState(() {
//       _isLoading = false;
//     });

//     await showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (ctx) => PersonalizedFeedbackModal(
//         isCorrect: isCorrect,
//         userAnswer: userAnswer,
//         questionText: _questions[_currentQuestionIndex].questionText,
//         correctAnswer: validationCorrectAnswer, // Pass the non-null string
//         lessonContent: _currentLesson!.content,
//         userProgress: _userProgress!,
//       ),
//     );

//     _goToNextQuestion();
//   }

//   void _goToNextQuestion() {
//     setState(() {
//       if (_currentQuestionIndex < _questions.length - 1) {
//         _currentQuestionIndex++;
//       } else {
//         _markLessonCompleted();
//       }
//     });
//   }

//   Future<void> _markLessonCompleted() async {
//     final firebaseUser = _firebaseService.currentUser;
//     if (firebaseUser == null || _currentLesson == null || _userProgress == null) {
//       return;
//     }

//     LessonProgress currentLessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id] ??
//         const LessonProgress(isCompleted: false, xpEarned: 0, questionAttempts: {});

//     if (!currentLessonProgress.isCompleted) {
//       currentLessonProgress = currentLessonProgress.copyWith(
//         isCompleted: true,
//         completedAt: DateTime.now(),
//       );

//       Map<String, LessonProgress> updatedLessonsProgress = Map.from(_userProgress!.lessonsProgress);
//       updatedLessonsProgress[_currentLesson!.id] = currentLessonProgress;

//       _userProgress = _userProgress!.copyWith(
//         lessonsProgress: updatedLessonsProgress,
//       );
//       await _firebaseService.saveUserProgress(_userProgress!);
//     }

//     // Check if current level is completed
//     List<Lesson> allLessonsInLevel = [];
//     try {
//       final levelRef = _firebaseService.getFirestore().collection(AppConstants.levelsCollection).doc(widget.levelId);
//       final lessonsSnapshot = await levelRef.collection('lessons').orderBy('order').get();
//       allLessonsInLevel = lessonsSnapshot.docs.map((doc) => Lesson.fromMap(doc.data())).toList();
//     } catch (e) {
//       debugPrint('Error fetching all lessons in level: $e');
//       // If error, assume lessons are not all fetched and handle gracefully
//       allLessonsInLevel = [];
//     }


//     bool allLessonsCompletedInLevel = allLessonsInLevel.isNotEmpty && allLessonsInLevel.every((lesson) {
//       return _userProgress!.lessonsProgress[lesson.id]?.isCompleted == true;
//     });

//     if (allLessonsCompletedInLevel) {
//       int totalXpEarnedInLevel = allLessonsInLevel.fold(0, (sum, lesson) => sum + (_userProgress!.lessonsProgress[lesson.id]?.xpEarned ?? 0));

//       LevelProgress currentLevelProgress = _userProgress!.levelsProgress[widget.levelId] ??
//           const LevelProgress(isCompleted: false, xpEarned: 0, score: 0);

//       currentLevelProgress = currentLevelProgress.copyWith(
//         isCompleted: true,
//         xpEarned: (currentLevelProgress.xpEarned) + totalXpEarnedInLevel, // Ensure xpEarned is not null
//         score: (totalXpEarnedInLevel / (allLessonsInLevel.length * 15 * (_questions.isNotEmpty ? _questions.length : 1))).round(), // Rough score calculation
//         completedAt: DateTime.now(),
//       );

//       Map<String, LevelProgress> updatedLevelsProgress = Map.from(_userProgress!.levelsProgress);
//       updatedLevelsProgress[widget.levelId] = currentLevelProgress;

//       _userProgress = _userProgress!.copyWith(
//         currentLevelId: null, // Reset current level as it's completed
//         currentLessonId: null, // Reset current lesson as it's completed
//         levelsProgress: updatedLevelsProgress,
//       );
//       await _firebaseService.saveUserProgress(_userProgress!);

//       // Check if course is completed
//       List<Level> allLevelsInCourse = [];
//       try {
//         final courseLevelsSnapshot = await _firebaseService.getFirestore()
//             .collection(AppConstants.levelsCollection)
//             .where('courseId', isEqualTo: widget.courseId)
//             .orderBy('order')
//             .get();
//         allLevelsInCourse = courseLevelsSnapshot.docs.map((doc) => Level.fromMap(doc.data())).toList();
//       } catch (e) {
//         debugPrint('Error fetching all levels in course: $e');
//         allLevelsInCourse = [];
//       }

//       bool allLevelsCompletedInCourse = allLevelsInCourse.isNotEmpty && allLevelsInCourse.every((level) {
//         return _userProgress!.levelsProgress[level.id]?.isCompleted == true;
//       });

//       if (mounted) {
//         Navigator.of(context).pushReplacementNamed(
//           AppRouter.levelCompletionRoute,
//           arguments: {
//             'courseId': widget.courseId,
//             'levelId': widget.levelId,
//             'xpEarned': totalXpEarnedInLevel,
//             'isCourseCompleted': allLevelsCompletedInCourse,
//           },
//         );
//       }
//     } else {
//       // If not all lessons in the current level are completed, go back to level selection
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Lesson completed! Continue to the next lesson or level.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         Navigator.of(context).pop(); // Go back to level selection
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: CustomAppBar(
//         title: _currentLevel?.title ?? 'Lesson',
//         subtitle: _currentLesson?.title,
//         automaticallyImplyLeading: true, // Allow back to level selection
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: _isLoading
//               ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//               : _errorMessage != null
//                   ? Center(child: Text(_errorMessage!, style: const TextStyle(color: AppColors.errorColor)))
//                   : Padding(
//                       padding: const EdgeInsets.all(AppConstants.padding),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (_questions.isNotEmpty)
//                             ProgressBar(
//                               current: _currentQuestionIndex,
//                               total: _questions.length,
//                             ),
//                           const SizedBox(height: AppConstants.spacing * 2),
//                           Expanded(
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Card(
//                                     color: AppColors.cardColor.withOpacity(0.9),
//                                     elevation: 5,
//                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(AppConstants.padding),
//                                       child: LessonContentDisplay(content: _currentLesson!.content),
//                                     ),
//                                   ),
//                                   const SizedBox(height: AppConstants.spacing * 2),
//                                   if (_questions.isNotEmpty && _currentQuestionIndex < _questions.length)
//                                     QuestionRenderer(
//                                       question: _questions[_currentQuestionIndex],
//                                       onSubmit: (userAnswer) {
//                                         // Ensure the correctAnswerData passed is never null
//                                         dynamic dataToSend;
//                                         // Directly use the correctAnswer from the current question for MCQ
//                                         if (_questions[_currentQuestionIndex].type == 'MCQ') {
//                                           dataToSend = _questions[_currentQuestionIndex].correctAnswer;
//                                         } else {
//                                           switch (_questions[_currentQuestionIndex].type) {
//                                             case 'FillInBlank':
//                                               dataToSend = _questions[_currentQuestionIndex].correctAnswer;
//                                               break;
//                                             case 'ShortAnswer':
//                                               dataToSend = _questions[_currentQuestionIndex].expectedAnswerKeywords;
//                                               break;
//                                             case 'Scenario':
//                                               dataToSend = _questions[_currentQuestionIndex].expectedOutcome;
//                                               break;
//                                             default:
//                                               dataToSend = ''; // Default for unknown types
//                                           }
//                                         }


//                                         _submitAnswer(
//                                           _questions[_currentQuestionIndex].id,
//                                           userAnswer,
//                                           _questions[_currentQuestionIndex].type,
//                                           dataToSend ?? '', // Ensure it's never null
//                                         );
//                                       },
//                                       isSubmitted: _questionAttemptStatus.containsKey(_questions[_currentQuestionIndex].id),
//                                       lastUserAnswer: _userAnswers[_questions[_currentQuestionIndex].id],
//                                       isLastAttemptCorrect: _questionAttemptStatus[_questions[_currentQuestionIndex].id],
//                                       xpAwarded: _xpAwardedPerQuestion[_questions[_currentQuestionIndex].id],
//                                     )
//                                   else if (_questions.isEmpty)
//                                     const Center(
//                                       child: Text(
//                                         'No questions for this lesson yet. Please try again later.',
//                                         style: TextStyle(color: AppColors.textColorSecondary),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           if (_questions.isNotEmpty && _currentQuestionIndex == _questions.length)
//                             Padding(
//                               padding: const EdgeInsets.only(top: AppConstants.padding),
//                               child: CustomButton(
//                                 onPressed: _markLessonCompleted,
//                                 text: 'Finish Lesson',
//                                 icon: Icons.flag,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 0), // Default to home in bottom nav
//     );
//   }
// }
// // lib/screens/home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/course/course_card.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:gamifier/widgets/common/xp_level_display.dart';
// import 'package:gamifier/widgets/gamification/streak_display.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   UserProfile? _userProfile;
//   late Stream<List<Course>> _coursesStream;
//   late FirebaseService _firebaseService;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     _loadUserProfile();
//     _coursesStream = _firebaseService.streamAllCourses();
//   }

//   Future<void> _loadUserProfile() async {
//     final user = _firebaseService.currentUser;
//     if (user != null) {
//       _firebaseService.streamUserProfile(user.uid).listen((profile) {
//         if (mounted) {
//           setState(() {
//             _userProfile = profile;
//           });
//         }
//       }).onError((error) {
//         debugPrint('Error loading user profile: $error');
//       });
//     }
//   }

//   void _onCourseTapped(Course course) {
//     Navigator.of(context).pushNamed(
//       AppRouter.levelSelectionRoute,
//       arguments: {
//         'courseId': course.id,
//         'courseTitle': course.title,
//       },
//     );
//   }

//   void _deleteCourse(Course course) async {
//     final bool? confirmDelete = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           backgroundColor: AppColors.cardColor,
//           title: const Text('Delete Course', style: TextStyle(color: AppColors.textColor)),
//           content: Text(
//             'Are you sure you want to delete "${course.title}"? This action cannot be undone.',
//             style: const TextStyle(color: AppColors.textColorSecondary),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(false);
//               },
//               child: const Text('Cancel', style: TextStyle(color: AppColors.accentColor)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(true);
//               },
//               child: const Text('Delete', style: TextStyle(color: AppColors.errorColor)),
//             ),
//           ],
//         );
//       },
//     );

//     if (confirmDelete == true) {
//       try {
//         await _firebaseService.deleteCourse(course.id, course.levelIds);
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Course deleted successfully!')),
//           );
//         }
//       } catch (e) {
//         debugPrint('Error deleting course: $e');
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to delete course: ${e.toString()}')),
//           );
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(
//         title: AppConstants.appName,
//         automaticallyImplyLeading: false, // Home screen is the root, no back button needed.
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(AppConstants.padding),
//                 child: _userProfile == null
//                     ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: AppConstants.avatarSize / 2,
//                                 backgroundImage: AssetImage(_userProfile!.avatarAssetPath),
//                                 backgroundColor: AppColors.borderColor,
//                               ),
//                               const SizedBox(width: AppConstants.spacing * 2),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Hello, ${_userProfile!.username}!',
//                                       style: AppColors.neonTextStyle(fontSize: 24),
//                                     ),
//                                     const SizedBox(height: AppConstants.spacing),
//                                     XpLevelDisplay(
//                                       xp: _userProfile!.xp,
//                                       level: _userProfile!.level,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: AppConstants.spacing * 2),
//                           StreakDisplay(currentStreak: _userProfile!.currentStreak),
//                         ],
//                       ),
//               ),
//               Expanded(
//                 child: StreamBuilder<List<Course>>(
//                   stream: _coursesStream,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
//                     }
//                     if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//                     }
//                     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           'No courses found. Create one to get started!',
//                           style: TextStyle(color: AppColors.textColorSecondary, fontSize: 18),
//                           textAlign: TextAlign.center,
//                         ),
//                       );
//                     }
//                     final courses = snapshot.data!;
//                     return ListView.builder(
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
//                       itemCount: courses.length,
//                       itemBuilder: (context, index) {
//                         final course = courses[index];
//                         return CourseCard(
//                           course: course,
//                           onTap: () => _onCourseTapped(course),
//                           onDelete: () => _deleteCourse(course),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 0),
//     );
//   }
// }
// // lib/screens/course_creation_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/course.dart';
// import 'package:gamifier/models/level.dart';
// import 'package:gamifier/models/lesson.dart';
// import 'package:gamifier/models/question.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/utils/app_router.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/course/course_form.dart';
// import 'package:gamifier/utils/file_picker_util.dart';

// class CourseCreationScreen extends StatefulWidget {
//   const CourseCreationScreen({super.key});

//   @override
//   State<CourseCreationScreen> createState() => _CourseCreationScreenState();
// }

// class _CourseCreationScreenState extends State<CourseCreationScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String _topicName = '';
//   String _domain = '';
//   String _difficulty = AppConstants.difficultyLevels[0];
//   String _educationLevel = AppConstants.educationLevels[0];
//   String _language = AppConstants.supportedLanguages[0]; // Changed from _gameGenre
//   String _sourceContent = '';
//   String _youtubeUrl = '';
//   bool _isLoading = false;
//   String? _errorMessage;

//   Future<void> _pickFile() async {
//     final content = await FilePickerUtil.pickTextFile();
//     if (content != null) {
//       setState(() {
//         _sourceContent = content;
//       });
//     }
//   }

//   Future<void> _createCourse() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     _formKey.currentState!.save();

//     if (_sourceContent.isEmpty && _youtubeUrl.isEmpty && _topicName.isEmpty) {
//       setState(() {
//         _errorMessage = 'Please provide a Topic Name or Source Content/YouTube URL.';
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final geminiService = Provider.of<GeminiApiService>(context, listen: false);
//     final currentUser = firebaseService.currentUser;

//     if (currentUser == null) {
//       setState(() {
//         _errorMessage = 'You must be logged in to create a course.';
//         _isLoading = false;
//       });
//       return;
//     }

//     try {
//       final String newCourseId = firebaseService.generateNewDocId();

//       final Map<String, dynamic> generatedData = await geminiService.generateCourseContent(
//         topicName: _topicName.isNotEmpty ? _topicName : 'Dynamic Course',
//         ageGroup: 'college student',
//         domain: _domain.isNotEmpty ? _domain : 'General Education',
//         difficulty: _difficulty,
//         educationLevel: _educationLevel,
//         specialty: _domain,
//         language: _language, // Pass the selected language
//         sourceContent: _sourceContent.isNotEmpty ? _sourceContent : null,
//         youtubeUrl: _youtubeUrl.isNotEmpty ? _youtubeUrl : null,
//         numberOfLevels: AppConstants.initialLevelsCount,
//       );

//       Course newCourse = Course(
//         id: newCourseId,
//         title: generatedData['courseTitle'] as String,
//         description: 'A dynamically generated course on ${generatedData['courseTitle']}.',
//         gameGenre: generatedData['gameGenre'] as String?, // Still read gameGenre from model if present
//         language: generatedData['language'] as String, // Read language from generated data
//         difficulty: generatedData['difficulty'] as String,
//         creatorId: currentUser.uid,
//         createdAt: DateTime.now(),
//       );

//       List<Level> levelsToSave = [];
//       Map<String, List<Lesson>> lessonsPerLevel = {};
//       Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};

//       if (generatedData['levels'] is List) { // Robust check for levels list
//         for (var levelData in generatedData['levels']) {
//           if (levelData is Map<String, dynamic>) { // Ensure each level item is a map
//             final level = Level.fromMap(levelData);
//             level.courseId = newCourseId;
//             levelsToSave.add(level);

//             List<Lesson> lessonsForThisLevel = [];
//             Map<String, List<Question>> questionsForThisLevelLessons = {};

//             if (levelData['lessons'] is List) { // Robust check for lessons list
//               for (var lessonData in (levelData['lessons'] as List)) {
//                 if (lessonData is Map<String, dynamic>) { // Ensure each lesson item is a map
//                   final lesson = Lesson.fromMap(lessonData);
//                   lesson.levelId = level.id;
//                   lessonsForThisLevel.add(lesson);

//                   List<Question> questionsForThisLesson = [];
//                   if (lessonData['questions'] is List) { // Robust check for questions list
//                     for (var questionData in (lessonData['questions'] as List)) {
//                       if (questionData is Map<String, dynamic>) { // Ensure each question item is a map
//                         questionsForThisLesson.add(Question.fromMap(questionData));
//                       } else {
//                         debugPrint('Warning: Skipping malformed question data: $questionData');
//                       }
//                     }
//                   }
//                   questionsForThisLevelLessons[lesson.id] = questionsForThisLesson;
//                 } else {
//                   debugPrint('Warning: Skipping malformed lesson data: $lessonData');
//                 }
//               }
//             }
//             lessonsPerLevel[level.id] = lessonsForThisLevel;
//             questionsPerLessonPerLevel[level.id] = questionsForThisLevelLessons;
//           } else {
//             debugPrint('Warning: Skipping malformed level data: $levelData');
//           }
//         }
//       }


//       newCourse = newCourse.copyWith(levelIds: levelsToSave.map((l) => l.id).toList());

//       await firebaseService.saveCourse(newCourse);
//       await firebaseService.saveLevels(levelsToSave, lessonsPerLevel, questionsPerLessonPerLevel);

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Course created successfully!')),
//         );
//         Navigator.of(context).pushReplacementNamed(AppRouter.levelSelectionRoute, arguments: {
//           'courseId': newCourse.id,
//           'courseTitle': newCourse.title,
//         });
//       }
//     } catch (e) {
//       debugPrint('Error creating course: $e');
//       setState(() {
//         _errorMessage = 'Failed to create course: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'Create New Course'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(AppConstants.padding),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   CourseForm(
//                     onTopicChanged: (value) => _topicName = value,
//                     onDomainChanged: (value) => _domain = value,
//                     onDifficultyChanged: (value) => setState(() => _difficulty = value!),
//                     onEducationLevelChanged: (value) => setState(() => _educationLevel = value!),
//                     onLanguageChanged: (value) => setState(() => _language = value!), // Changed here
//                     onYoutubeUrlChanged: (value) => _youtubeUrl = value,
//                     onSourceContentChanged: (value) => _sourceContent = value,
//                     currentDifficulty: _difficulty,
//                     currentEducationLevel: _educationLevel,
//                     currentLanguage: _language, // Changed here
//                   ),
//                   const SizedBox(height: AppConstants.spacing * 2),
//                   CustomButton(
//                     onPressed: _pickFile,
//                     text: 'Upload Course Material (Text/PDF)',
//                     icon: Icons.upload_file,
//                   ),
//                   if (_sourceContent.isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                       child: Text(
//                         'File selected. Content length: ${_sourceContent.length} characters.',
//                         style: const TextStyle(color: AppColors.textColorSecondary),
//                       ),
//                     ),
//                   const SizedBox(height: AppConstants.spacing * 2),
//                   if (_errorMessage != null)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: AppConstants.spacing),
//                       child: Text(
//                         _errorMessage!,
//                         style: const TextStyle(color: AppColors.errorColor),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   _isLoading
//                       ? const CircularProgressIndicator(color: AppColors.accentColor)
//                       : CustomButton(
//                           onPressed: _createCourse,
//                           text: 'Generate Course',
//                           icon: Icons.auto_awesome,
//                         ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 4),
//     );
//   }
// }
// // lib/screens/community_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/community_post.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';
// import 'package:gamifier/widgets/community/post_card.dart';

// class CommunityScreen extends StatefulWidget {
//   const CommunityScreen({super.key});

//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }

// class _CommunityScreenState extends State<CommunityScreen> {
//   final TextEditingController _postController = TextEditingController();
//   UserProfile? _currentUserProfile;
//   bool _isLoadingPost = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     final user = firebaseService.currentUser;
//     if (user != null) {
//       final profile = await firebaseService.getUserProfile(user.uid);
//       setState(() {
//         _currentUserProfile = profile;
//       });
//     }
//   }

//   Future<void> _createPost() async {
//     if (_postController.text.trim().isEmpty || _currentUserProfile == null) {
//       return;
//     }

//     setState(() {
//       _isLoadingPost = true;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final newPost = CommunityPost(
//         id: firebaseService.generateNewDocId(),
//         authorId: _currentUserProfile!.uid,
//         authorUsername: _currentUserProfile!.username,
//         authorAvatarUrl: _currentUserProfile!.avatarAssetPath,
//         content: _postController.text.trim(),
//         timestamp: DateTime.now(),
//       );
//       await firebaseService.createCommunityPost(newPost);
//       _postController.clear();
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Post created successfully!')),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error creating post: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to create post: ${e.toString()}')),
//         );
//       }
//     } finally {
//       setState(() {
//         _isLoadingPost = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _postController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'Community Feed'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(AppConstants.padding),
//                 child: Column(
//                   children: [
//                     CustomTextField(
//                       controller: _postController,
//                       labelText: 'Share your thoughts or achievements!',
//                       icon: Icons.edit,
//                       maxLines: 3,
//                       keyboardType: TextInputType.multiline,
//                     ),
//                     const SizedBox(height: AppConstants.spacing),
//                     CustomButton(
//                       onPressed: _isLoadingPost ? null : _createPost,
//                       text: 'Create Post',
//                       icon: Icons.send,
//                       isLoading: _isLoadingPost,
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: StreamBuilder<List<CommunityPost>>(
//                   stream: Provider.of<FirebaseService>(context).streamCommunityPosts(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
//                     }
//                     if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//                     }
//                     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           'No posts yet. Be the first to share!',
//                           style: TextStyle(color: AppColors.textColorSecondary),
//                         ),
//                       );
//                     }
//                     final posts = snapshot.data!;
//                     return ListView.builder(
//                       itemCount: posts.length,
//                       itemBuilder: (context, index) {
//                         return PostCard(post: posts[index], currentUserId: _currentUserProfile?.uid);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 2),
//     );
//   }
// }
// // lib/screens/chat_screen.dart
// import 'package:flutter/material.dart';
// import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/chat_message.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/services/gemini_api_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_text_field.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   UserProfile? _currentUserProfile;
//   late FirebaseService _firebaseService;
//   late GeminiApiService _geminiApiService;
//   bool _isGeneratingResponse = false;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseService = Provider.of<FirebaseService>(context, listen: false);
//     _geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     final user = _firebaseService.currentUser;
//     if (user != null) {
//       final profile = await _firebaseService.getUserProfile(user.uid);
//       setState(() {
//         _currentUserProfile = profile;
//       });
//     }
//   }

//   void _sendMessage() async {
//     if (_messageController.text.trim().isEmpty || _currentUserProfile == null || _isGeneratingResponse) {
//       return;
//     }

//     final String messageText = _messageController.text.trim();
//     _messageController.clear();

//     final userMessage = ChatMessage(
//       id: _firebaseService.generateNewDocId(),
//       senderId: _currentUserProfile!.uid,
//       senderUsername: _currentUserProfile!.username,
//       senderAvatarUrl: _currentUserProfile!.avatarAssetPath,
//       text: messageText,
//       timestamp: DateTime.now(),
//       isUser: true,
//     );

//     await _firebaseService.sendChatMessage(userMessage);

//     setState(() {
//       _isGeneratingResponse = true;
//     });

//     try {
//       final chatHistorySnapshot = await _firebaseService.getFirestore()
//           .collection(AppConstants.chatMessagesCollection)
//           .orderBy('timestamp', descending: false)
//           .get();
//       final List<ChatMessage> currentChatHistory = chatHistorySnapshot.docs
//           .map((doc) => ChatMessage.fromMap(doc.data()))
//           .toList();

//       final String aiResponseText = await _geminiApiService.generateChatResponse(currentChatHistory);

//       final aiMessage = ChatMessage(
//         id: _firebaseService.generateNewDocId(),
//         senderId: 'ai_tutor',
//         senderUsername: 'AI Tutor',
//         senderAvatarUrl: 'assets/app_icon.png',
//         text: aiResponseText,
//         timestamp: DateTime.now(),
//         isUser: false,
//       );
//       await _firebaseService.sendChatMessage(aiMessage);
//     } catch (e) {
//       debugPrint('Error generating AI response: $e');
//       final errorMessage = ChatMessage(
//         id: _firebaseService.generateNewDocId(),
//         senderId: 'ai_tutor',
//         senderUsername: 'AI Tutor',
//         senderAvatarUrl: 'assets/app_icon.png',
//         text: 'Sorry, I am having trouble connecting right now. Please try again later.',
//         timestamp: DateTime.now(),
//         isUser: false,
//       );
//       await _firebaseService.sendChatMessage(errorMessage);
//     } finally {
//       setState(() {
//         _isGeneratingResponse = false;
//       });
//       _scrollToBottom();
//     }
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'AI Chat Tutor 🤖'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: StreamBuilder<List<ChatMessage>>(
//                   stream: _firebaseService.streamChatMessages(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator(color: AppColors.accentColor));
//                     }
//                     if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: AppColors.errorColor)));
//                     }
//                     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           'Start a conversation with your AI tutor!',
//                           style: TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
//                           textAlign: TextAlign.center,
//                         ),
//                       );
//                     }

//                     final messages = snapshot.data!;
//                     _scrollToBottom();

//                     return ListView.builder(
//                       controller: _scrollController,
//                       padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.padding / 2),
//                       itemCount: messages.length + (_isGeneratingResponse ? 1 : 0),
//                       itemBuilder: (context, index) {
//                         if (index == messages.length) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.cardColor,
//                                   borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                                 ),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Image.asset(
//                                       'assets/app_icon.png',
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                     const SizedBox(width: AppConstants.spacing),
//                                     const Text(
//                                       'AI Tutor is typing...',
//                                       style: TextStyle(color: AppColors.textColorSecondary),
//                                     ),
//                                     const SizedBox(width: AppConstants.spacing / 2),
//                                     const SizedBox(
//                                       width: 16,
//                                       height: 16,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         }

//                         final message = messages[index];
//                         final bool isMe = message.senderId == _currentUserProfile?.uid;

//                         return Align(
//                           alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
//                             padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.spacing),
//                             decoration: BoxDecoration(
//                               color: isMe ? AppColors.primaryColor.withOpacity(0.8) : AppColors.cardColor,
//                               borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                             ),
//                             constraints: BoxConstraints(
//                               maxWidth: MediaQuery.of(context).size.width * 0.75,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 12,
//                                       backgroundImage: AssetImage(message.senderAvatarUrl),
//                                       backgroundColor: AppColors.borderColor,
//                                     ),
//                                     const SizedBox(width: AppConstants.spacing),
//                                     Text(
//                                       message.senderUsername,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: isMe ? AppColors.textColor : AppColors.accentColor,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: AppConstants.spacing / 2),
//                                 Text(
//                                   message.text,
//                                   style: TextStyle(color: isMe ? AppColors.textColor : AppColors.textColorSecondary, fontSize: 16),
//                                 ),
//                                 const SizedBox(height: AppConstants.spacing / 2),
//                                 Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: Text(
//                                     '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
//                                     style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 10),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(AppConstants.padding),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextField(
//                         controller: _messageController,
//                         labelText: 'Type your message...',
//                         icon: Icons.message,
//                         keyboardType: TextInputType.text,
//                         onSubmitted: (value) => _sendMessage(),
//                       ),
//                     ),
//                     const SizedBox(width: AppConstants.spacing),
//                     Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(AppConstants.borderRadius),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.primaryColor.withOpacity(0.4),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: IconButton(
//                         icon: _isGeneratingResponse
//                             ? const CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.textColor),
//                               )
//                             : const Icon(Icons.send, color: AppColors.textColor),
//                         onPressed: _isGeneratingResponse ? null : _sendMessage,
//                         padding: const EdgeInsets.all(AppConstants.spacing * 1.5),
//                         splashRadius: 24,
//                         tooltip: 'Send Message',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const BottomNavBar(currentIndex: 3),
//     );
//   }
// }
// // lib/screens/avatar_customizer_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gamifier/constants/app_colors.dart';
// import 'package:gamifier/constants/app_constants.dart';
// import 'package:gamifier/models/avatar_asset.dart';
// import 'package:gamifier/services/firebase_service.dart';
// import 'package:gamifier/models/user_profile.dart';
// import 'package:gamifier/widgets/common/custom_app_bar.dart';
// import 'package:gamifier/widgets/common/custom_button.dart';
// import 'package:gamifier/widgets/gamification/avatar_customizer.dart';

// class AvatarCustomizerScreen extends StatefulWidget {
//   const AvatarCustomizerScreen({super.key});

//   @override
//   State<AvatarCustomizerScreen> createState() => _AvatarCustomizerScreenState();
// }

// class _AvatarCustomizerScreenState extends State<AvatarCustomizerScreen> {
//   String? _selectedAvatarPath;
//   UserProfile? _userProfile;
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       final currentUser = firebaseService.currentUser;
//       if (currentUser != null) {
//         final profile = await firebaseService.getUserProfile(currentUser.uid);
//         setState(() {
//           _userProfile = profile;
//           _selectedAvatarPath = profile?.avatarAssetPath;
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'User not logged in.';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load user profile: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _onAvatarSelected(AvatarAsset avatar) {
//     setState(() {
//       _selectedAvatarPath = avatar.assetPath;
//     });
//   }

//   Future<void> _saveAvatar() async {
//     if (_userProfile == null || _selectedAvatarPath == null) {
//       setState(() {
//         _errorMessage = 'No avatar selected or user profile not loaded.';
//       });
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final firebaseService = Provider.of<FirebaseService>(context, listen: false);
//       await firebaseService.updateUserProfile(
//         _userProfile!.uid,
//         {'avatarAssetPath': _selectedAvatarPath},
//       );
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Avatar updated successfully!')),
//         );
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to save avatar: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(title: 'Customize Avatar'),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: AppColors.backgroundGradient(),
//         ),
//         child: SafeArea(
//           child: _isLoading
//               ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
//               : _errorMessage != null
//                   ? Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(AppConstants.padding),
//                         child: Text(
//                           _errorMessage!,
//                           style: const TextStyle(color: AppColors.errorColor),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     )
//                   : Column(
//                       children: [
//                         Expanded(
//                           child: AvatarCustomizer(
//                             selectedAvatarPath: _selectedAvatarPath,
//                             onAvatarSelected: _onAvatarSelected,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(AppConstants.padding),
//                           child: CustomButton(
//                             onPressed: _saveAvatar,
//                             text: 'Save Avatar',
//                             icon: Icons.save,
//                             isLoading: _isLoading,
//                           ),
//                         ),
//                       ],
//                     ),
//         ),
//       ),
//     );
//   }
// }