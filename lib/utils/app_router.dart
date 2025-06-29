// lib/utils/app_router.dart
import 'package:flutter/material.dart';
import 'package:gamifier/screens/auth_screen.dart';
import 'package:gamifier/screens/home_screen.dart';
import 'package:gamifier/screens/onboarding_screen.dart';
import 'package:gamifier/screens/progress_screen.dart';
import 'package:gamifier/screens/community_screen.dart';
import 'package:gamifier/screens/chat_screen.dart';
import 'package:gamifier/screens/course_creation_screen.dart';
import 'package:gamifier/screens/level_selection_screen.dart';
import 'package:gamifier/screens/lesson_screen.dart';
import 'package:gamifier/screens/level_completion_screen.dart';
import 'package:gamifier/screens/profile_screen.dart';
import 'package:gamifier/screens/avatar_customizer_screen.dart';
import 'package:gamifier/screens/leaderboard_page.dart';
import 'package:gamifier/screens/splash_screen.dart'; // Import the new LeaderboardPage

class AppRouter {
  static const String authRoute = '/auth';
  static const String homeRoute = '/home';
  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String progressRoute = '/progress';
  static const String leaderboardRoute = '/leaderboard'; // New leaderboard route
  static const String communityRoute = '/community';
  static const String chatRoute = '/chat';
  static const String courseCreationRoute = '/course_creation';
  static const String levelSelectionRoute = '/level_selection';
  static const String lessonRoute = '/lesson';
  static const String levelCompletionRoute = '/level_completion';
  static const String profileRoute = '/profile';
  static const String avatarCustomizerRoute = '/avatar_customizer';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case authRoute:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case progressRoute:
        return MaterialPageRoute(builder: (_) => const ProgressScreen());
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case leaderboardRoute: // Define the route for LeaderboardPage
        return MaterialPageRoute(builder: (_) => const LeaderboardPage());
      case communityRoute:
        return MaterialPageRoute(builder: (_) => const CommunityScreen());
      case chatRoute:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case courseCreationRoute:
        return MaterialPageRoute(builder: (_) => const CourseCreationScreen());
      case levelSelectionRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null && args.containsKey('courseId') && args.containsKey('courseTitle')) {
          return MaterialPageRoute(
            builder: (_) => LevelSelectionScreen(
              courseId: args['courseId'] as String,
              courseTitle: args['courseTitle'] as String,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const Text('Error: Course ID or Title not provided.'));
      case lessonRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null &&
            args.containsKey('courseId') &&
            args.containsKey('levelId') &&
            args.containsKey('lessonId') &&
            args.containsKey('levelOrder')) {
          return MaterialPageRoute(
            builder: (_) => LessonScreen(
              courseId: args['courseId'] as String,
              levelId: args['levelId'] as String,
              lessonId: args['lessonId'] as String,
              levelOrder: args['levelOrder'] as int,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const Text('Error: Lesson arguments not provided.'));
      case levelCompletionRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null && args.containsKey('courseId') && args.containsKey('levelId') && args.containsKey('xpEarned')) {
          return MaterialPageRoute(
            builder: (_) => LevelCompletionScreen(
              courseId: args['courseId'] as String,
              levelId: args['levelId'] as String,
              xpEarned: args['xpEarned'] as int,
              isCourseCompleted: args['isCourseCompleted'] as bool? ?? false,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const Text('Error: Level completion arguments not provided.'));
      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case avatarCustomizerRoute:
        return MaterialPageRoute(builder: (_) => const AvatarCustomizerScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Text('Error: Unknown route'));
    }
  }
}
