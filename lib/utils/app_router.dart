// lib/utils/app_router.dart
import 'package:flutter/material.dart';
import 'package:gamifier/screens/auth_screen.dart';
import 'package:gamifier/screens/splash_screen.dart';
import 'package:gamifier/screens/onboarding_screen.dart';
import 'package:gamifier/screens/home_screen.dart';
import 'package:gamifier/screens/profile_screen.dart';
import 'package:gamifier/screens/avatar_customizer_screen.dart';
import 'package:gamifier/screens/course_creation_screen.dart';
import 'package:gamifier/screens/level_selection_screen.dart';
import 'package:gamifier/screens/lesson_screen.dart';
import 'package:gamifier/screens/level_completion_screen.dart';
import 'package:gamifier/screens/chat_screen.dart';
import 'package:gamifier/screens/community_screen.dart';
import 'package:gamifier/screens/progress_screen.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String authRoute = '/auth';
  static const String onboardingRoute = '/onboarding';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String avatarCustomizerRoute = '/avatar_customizer';
  static const String courseCreationRoute = '/course_creation';
  static const String levelSelectionRoute = '/level_selection';
  static const String lessonRoute = '/lesson';
  static const String levelCompletionRoute = '/level_completion';
  static const String chatRoute = '/chat';
  static const String communityRoute = '/community';
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
      case avatarCustomizerRoute:
        return MaterialPageRoute(builder: (_) => const AvatarCustomizerScreen());
      case courseCreationRoute:
        return MaterialPageRoute(builder: (_) => const CourseCreationScreen());
      case levelSelectionRoute:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(builder: (_) => LevelSelectionScreen(courseId: args['courseId']!, courseTitle: args['courseTitle']!));
      case lessonRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => LessonScreen(
          courseId: args['courseId']!,
          levelId: args['levelId']!,
          lessonId: args['lessonId']!,
          levelOrder: args['levelOrder']!,
        ));
      case levelCompletionRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => LevelCompletionScreen(
          courseId: args['courseId']!,
          levelId: args['levelId']!,
          xpEarned: args['xpEarned']!,
          isCourseCompleted: args['isCourseCompleted'] ?? false,
        ));
      case chatRoute:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case communityRoute:
        return MaterialPageRoute(builder: (_) => const CommunityScreen());
      case progressRoute:
        return MaterialPageRoute(builder: (_) => const ProgressScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Text('Error: Unknown route'));
    }
  }
}