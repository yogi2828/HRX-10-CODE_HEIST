// lib/constants/app_constants.dart
import 'package:gamifier/models/avatar_asset.dart';

class AppConstants {
  static const String geminiApiKey = '';

  static const String usersCollection = 'users';
  static const String coursesCollection = 'courses';
  static const String lessonsCollection = 'lessons';
  static const String userProgressCollection = 'user_progress';
  static const String badgesCollection = 'badges';
  static const String leaderboardsCollection = 'leaderboard';
  static const String levelsCollection = 'levels';
  static const String communityPostsCollection = 'community_posts';

  static const int maxUsernameLength = 20;
  static const int minPasswordLength = 6;
  static const int initialXp = 0;
  static const int xpPerLevel = 100;
  static const int xpPerCorrectAnswer = 10;
  static const int leaderboardLimit = 10;

  static const int initialStreak = 0;
  static const int streakBonusXp = 5;
  static const int levelXpDeductionOnReattempt = 20;

  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);
  static const Duration shimmerAnimationDuration = Duration(milliseconds: 1500);

  static const double borderRadius = 16.0;
  static const double padding = 16.0;
  static const double spacing = 8.0;
  static const double iconSize = 24.0;
  static const double avatarSize = 64.0;
  static const double badgeSize = 48.0;

  static const double largeTextSize = 22.0;
  static const double mediumTextSize = 16.0;
  static const double smallTextSize = 14.0;
  static const double extraSmallTextSize = 12.0;

  static const String appName = 'Gamifier';
  static const String appTagline = 'Learn. Play. Conquer.';
  static const String defaultFontFamily = 'Inter';

  static const double geminiTemperature = 0.7;
  static const int geminiMaxOutputTokens = 2000;

  static const List<AvatarAsset> defaultAvatarAssets = [
    AvatarAsset(id: 'avatar1', name: 'Adventurer', assetPath: 'assets/avatars/avatar1.png'),
    AvatarAsset(id: 'avatar2', name: 'Explorer', assetPath: 'assets/avatars/avatar2.png'),
    AvatarAsset(id: 'avatar3', name: 'Wizard', assetPath: 'assets/avatars/avatar3.png'),
    AvatarAsset(id: 'avatar4', name: 'Knight', assetPath: 'assets/avatars/avatar4.png'),
  ];

  static const String correctSoundPath = 'assets/audios/correct.mp3';
  static const String levelUpSoundPath = 'assets/audios/level_up.mp3';
  static const String incorrectSoundPath = 'assets/audios/incorrect.mp3';

  static const List<String> gameThemes = [
    'Fantasy',
    'Sci-Fi',
    'Adventure',
    'Mystery',
    'Cyberpunk',
  ];

  static const List<String> difficultyLevels = [
    'Beginner',
    'Novice',
    'Intermediate',
    'Proficient',
    'Advanced',
    'Expert',
    'Master',
    'Grandmaster',
    'Legendary',
    'Mythic',
  ];

  static const List<String> educationLevels = [
    'High School',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'PhD',
    'Other',
  ];

  static const List<String> defaultCourseTopics = [
    'Introduction to Python',
    'Fundamentals of Web Development',
    'Basic Algebra',
    'History of Ancient Civilizations',
    'Understanding Climate Change',
  ];
}
