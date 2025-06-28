// lib/screens/level_completion_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/services/audio_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/common/xp_level_display.dart';

class LevelCompletionScreen extends StatefulWidget {
  final String courseId;
  final String levelId;
  final int xpEarned;
  final bool isCourseCompleted;

  const LevelCompletionScreen({
    super.key,
    required this.courseId,
    required this.levelId,
    required this.xpEarned,
    this.isCourseCompleted = false,
  });

  @override
  State<LevelCompletionScreen> createState() => _LevelCompletionScreenState();
}

class _LevelCompletionScreenState extends State<LevelCompletionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late AudioService _audioService;
  int _currentXp = 0;
  int _currentLevel = 0;

  @override
  void initState() {
    super.initState();
    _audioService = Provider.of<AudioService>(context, listen: false);
    _audioService.playLevelUpSound();
    _loadUserProfile();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  Future<void> _loadUserProfile() async {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final user = firebaseService.currentUser;
    if (user != null) {
      firebaseService.streamUserProfile(user.uid).listen((profile) {
        if (mounted && profile != null) {
          setState(() {
            _currentXp = profile.xp;
            _currentLevel = profile.level;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.padding * 2),
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Card(
                  color: AppColors.cardColor.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
                    side: const BorderSide(color: AppColors.accentColor, width: 2),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding * 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: AppColors.successColor,
                          size: 80,
                        ),
                        const SizedBox(height: AppConstants.spacing * 2),
                        Text(
                          widget.isCourseCompleted ? 'Course Completed!' : 'Level Completed!',
                          style: AppColors.neonTextStyle(fontSize: 28, color: AppColors.accentColor),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConstants.spacing),
                        Text(
                          'You earned ${widget.xpEarned} XP!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.xpColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConstants.spacing * 2),
                        XpLevelDisplay(xp: _currentXp, level: _currentLevel),
                        const SizedBox(height: AppConstants.spacing * 4),
                        CustomButton(
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.settings.name == AppRouter.levelSelectionRoute);
                            Navigator.of(context).pushReplacementNamed(
                              AppRouter.levelSelectionRoute,
                              arguments: {
                                'courseId': widget.courseId,
                                'courseTitle': '', // Title is not strictly needed for this navigation, but required by route args.
                              },
                            );
                          },
                          text: widget.isCourseCompleted ? 'Back to Courses' : 'Continue Learning',
                          icon: widget.isCourseCompleted ? Icons.home : Icons.play_arrow,
                        ),
                        const SizedBox(height: AppConstants.spacing),
                        CustomButton(
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.settings.name == AppRouter.homeRoute);
                            Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
                          },
                          text: 'Go to Home',
                          icon: Icons.home,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}