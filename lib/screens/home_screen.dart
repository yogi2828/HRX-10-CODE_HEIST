// gamifier/lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/models/course.dart'; // Import Course model
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/common/flash_card.dart';
import 'package:gamifier/widgets/gamification/leaderboard_list.dart';
import 'package:gamifier/widgets/gamification/streak_display.dart';
import 'package:gamifier/widgets/course/course_card.dart'; // To display popular courses

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProfile? _userProfile;
  List<Course> _popularCourses = [];
  late FirebaseService _firebaseService;
  int _currentFlashcardIndex = 0;
  List<Map<String, String>> _flashcards = [];

  @override
  void initState() {
    super.initState();
    _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    _loadUserProfile();
    _loadPopularCourses();
    _generateFlashcards();
  }

  Future<void> _loadUserProfile() async {
    final profile = await _firebaseService.streamUserProfile().first;
    if (mounted) {
      setState(() {
        _userProfile = profile;
      });
    }
  }

  Future<void> _loadPopularCourses() async {
    final courses = await _firebaseService.getPopularCourses(limit: 3); // Fetch top 3 popular courses
    if (mounted) {
      setState(() {
        _popularCourses = courses;
      });
    }
  }

  void _generateFlashcards() {
    // These flashcards would ideally come from a service or user preferences
    _flashcards = [
      {'front': 'What is Gamification?', 'back': 'Applying game-design elements and game principles in non-game contexts.'},
      {'front': 'What is XP?', 'back': 'Experience Points, a measure of progress in a gamified system.'},
      {'front': 'What is a Streak?', 'back': 'A continuous run of successful actions, rewarded for consistency.'},
      {'front': 'Why use Gamification in Learning?', 'back': 'To increase engagement, motivation, and knowledge retention.'},
      {'front': 'What is a Leaderboard?', 'back': 'A list ranking participants based on a score or metric.'},
    ];
  }

  void _nextFlashcard() {
    setState(() {
      _currentFlashcardIndex = (_currentFlashcardIndex + 1) % _flashcards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows content to go behind the app bar
      appBar: const TopNavBar(), // Use the new TopNavBar
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppConstants.topNavBarHeight + AppConstants.padding), // Space below TopNavBar

              // Hero Section - Greeting and Call to Action
              _buildHeroSection(),
              const SizedBox(height: AppConstants.padding * 2),

              // Gamification Statistics (XP, Level, Streak - now in TopNavBar for XP/Level)
              Center(
                child: StreakDisplay(
                  currentStreak: _userProfile?.currentStreak ?? 0,
                  longestStreak: _userProfile?.longestStreak ?? 0,
                ),
              ),
              const SizedBox(height: AppConstants.padding * 2),

              // Flash Cards Section
              Text(
                'Daily Brain Boost',
                style: AppColors.neonTextStyle(fontSize: 28, color: AppColors.accentColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacing * 2),
              Center(
                child: FlashCard(
                  frontText: _flashcards[_currentFlashcardIndex]['front']!,
                  backText: _flashcards[_currentFlashcardIndex]['back']!,
                  onNext: _nextFlashcard,
                ),
              ),
              const SizedBox(height: AppConstants.padding * 2),

              // Popular Courses Section
              Text(
                'Explore Popular Courses',
                style: AppColors.neonTextStyle(fontSize: 28, color: AppColors.secondaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacing * 2),
              _buildPopularCoursesSection(),
              const SizedBox(height: AppConstants.padding * 2),

              // Leaderboard Section
              Text(
                'Top Gamifiers',
                style: AppColors.neonTextStyle(fontSize: 28, color: AppColors.accentColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacing * 2),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  border: Border.all(color: AppColors.borderColor, width: 1),
                ),
                padding: const EdgeInsets.all(AppConstants.padding),
                child: LeaderboardList(
                  firebaseService: _firebaseService,
                ),
              ),
              const SizedBox(height: AppConstants.padding * 2),

              // Call to Action: Create Your Own Course
              Center(
                child: CustomButton(
                  text: 'Create Your Own Course',
                  icon: Icons.add_rounded,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRouter.courseCreationRoute);
                  },
                  width: MediaQuery.of(context).size.width * 0.6, // Responsive width
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              const SizedBox(height: AppConstants.padding),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.padding * 2, horizontal: AppConstants.padding),
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient(),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.6),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome, ${_userProfile?.username ?? 'Learner'}!',
            style: AppColors.neonTextStyle(
              fontSize: 42,
              fontWeight: FontWeight.extrabold,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacing),
          Text(
            AppConstants.appTagline,
            style: TextStyle(
              fontSize: 22,
              color: AppColors.textColorSecondary,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.padding),
          CustomButton(
            text: 'Start Learning',
            icon: Icons.play_arrow_rounded,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.levelSelectionRoute);
            },
            isSecondary: true,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.accentColor),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularCoursesSection() {
    if (_popularCourses.isEmpty) {
      return Center(
        child: Text(
          'No popular courses yet. Be the first to create one!',
          style: TextStyle(color: AppColors.textColorSecondary),
        ),
      );
    }
    return Align(
      alignment: Alignment.center,
      child: Wrap(
        spacing: AppConstants.padding,
        runSpacing: AppConstants.padding,
        alignment: WrapAlignment.center,
        children: _popularCourses.map((course) {
          return CourseCard(course: course);
        }).toList(),
      ),
    );
  }
}