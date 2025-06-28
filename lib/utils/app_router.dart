// lib/utils/app_router.dart
import 'package:flutter/material.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/screens/ai_chat_screen.dart';
import 'package:gamifier/screens/auth_screen.dart';
import 'package:gamifier/screens/avatar_customizer_screen.dart';
import 'package:gamifier/screens/community_screen.dart';
import 'package:gamifier/screens/course_creation_screen.dart';
import 'package:gamifier/screens/course_completion_screen.dart';
import 'package:gamifier/screens/home_screen.dart';
import 'package:gamifier/screens/level_completion_screen.dart';
import 'package:gamifier/screens/level_selection_screen.dart';
import 'package:gamifier/screens/lesson_screen.dart';
import 'package:gamifier/screens/onboarding_screen.dart';
import 'package:gamifier/screens/profile_screen.dart';
import 'package:gamifier/screens/progress_screen.dart';
import 'package:gamifier/screens/splash_screen.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String authRoute = '/auth';
  static const String onboardingRoute = '/onboarding';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String aiChatRoute = '/ai-chat';
  static const String communityRoute = '/community';
  static const String courseCreationRoute = '/course-creation';
  static const String levelSelectionRoute = '/level-selection';
  static const String lessonRoute = '/lesson';
  static const String levelCompletionRoute = '/level-completion';
  static const String courseCompletionRoute = '/course-completion';
  static const String avatarCustomizerRoute = '/avatar-customizer';
  static const String progressRoute = '/progress';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case authRoute:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case aiChatRoute:
        return MaterialPageRoute(builder: (_) => const AIChatScreen());
      case communityRoute:
        return MaterialPageRoute(builder: (_) => const CommunityScreen());
      case courseCreationRoute:
        return MaterialPageRoute(builder: (_) => const CourseCreationScreen());
      case levelSelectionRoute:
        final courseId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => LevelSelectionScreen(courseId: courseId));
      case lessonRoute:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(builder: (_) => LessonScreen(courseId: args['courseId']!, levelId: args['levelId']!));
      case levelCompletionRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => LevelCompletionScreen(
                  levelTitle: args['levelTitle'] as String,
                  xpEarned: args['xpEarned'] as int,
                  newLevel: args['newLevel'] as int,
                ));
      case courseCompletionRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => CourseCompletionScreen(
                  courseTitle: args['courseTitle'] as String,
                  totalXpEarned: args['totalXpEarned'] as int,
                  newBadgesEarned: args['newBadgesEarned'] as int? ?? 0,
                ));
      case progressRoute:
        return MaterialPageRoute(builder: (_) => const ProgressScreen());
      case avatarCustomizerRoute:
        final userProfile = settings.arguments as UserProfile;
        return MaterialPageRoute(builder: (_) => AvatarCustomizerScreen(userProfile: userProfile));
      default:
        return MaterialPageRoute(builder: (_) => const Text('Error: Unknown route'));
    }
  }
}
