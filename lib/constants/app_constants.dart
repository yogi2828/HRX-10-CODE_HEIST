// gamifier/lib/constants/app_constants.dart
import 'package:flutter/material.dart';
import 'package:gamifier/models/avatar_asset.dart';

class AppConstants {
  static const String appName = 'Gamifier';
  static const String appTagline = 'Learn. Play. Conquer.';

  // API Keys (Keep as is, user requested no change to AI calls)
  static const String geminiApiKey = 'AIzaSyDZ6yDuQgQWxzc5Qq24Dpf_BkvcOjx_SP8'; 

  // Firestore Collection Names (Keep as is, user requested no change to Firebase calls)
  static const String usersCollection = 'users';
  static const String coursesCollection = 'courses';
  static const String levelsCollection = 'levels';
  static const String lessonsCollection = 'lessons'; 
  static const String questionsCollection = 'questions'; 
  static const String userProgressCollection = 'userProgress';
  static const String badgesCollection = 'badges';
  static const String communityPostsCollection = 'communityPosts';
  static const String chatMessagesCollection = 'chatMessages';

  // App theming and UI for Web
  static const double padding = 20.0; // Increased padding for web
  static const double spacing = 10.0; // Adjusted spacing
  static const double borderRadius = 16.0; // Larger border radius for web elements
  static const double iconSize = 28.0; // Larger icons
  static const double avatarSize = 80.0; // Larger avatars
  static const double badgeSize = 90.0; // Larger badges
  static const Duration defaultAnimationDuration = Duration(milliseconds: 400); // Slightly longer for smoother web transitions
  static const Duration splashScreenDuration = Duration(seconds: 3); // Splash screen duration

  // Gamification Constants (Keep as is)
  static const int initialXp = 0;
  static const int xpPerLevel = 100;
  static const int leaderboardLimit = 10;
  static const int minStreakDaysForBonus = 3;
  static const int streakBonusXp = 20;

  // Course Generation Constants (Keep as is)
  static const int initialLevelsCount = 5; 
  static const int subsequentLevelsBatchSize = 5; 
  static const int maxLevelsPerCourse = 15; 

  // UI specific constants
  static const double levelSelectionGenerateButtonHeight = 150.0; 
  static const double topNavBarHeight = 70.0; // Height for the new top navigation bar

  // Default Content for Placeholders/Initial Data (Keep as is)
  static String defaultFontFamily = 'Inter';

  static const double geminiTemperature = 0.7;
  static const int geminiMaxOutputTokens = 2000;

  static const List<AvatarAsset> defaultAvatarAssets = [
    AvatarAsset(id: 'avatar1', name: 'Adventurer', assetPath: 'assets/avatars/avatar1.png'),
    AvatarAsset(id: 'avatar2', name: 'Explorer', assetPath: 'assets/avatars/avatar2.png'),
    AvatarAsset(id: 'avatar3', name: 'Wizard', assetPath: 'assets/avatars/avatar3.png'),
    AvatarAsset(id: 'avatar4', name: 'Knight', assetPath: 'assets/avatars/avatar4.png'),
  ];

  static const String correctSoundPath = 'audios/correct.mp3';
  static const String levelUpSoundPath = 'audios/level_up.mp3';

  static const List<String> supportedLanguages = [
    'English', 'Hindi', 'Marathi', 'Bengali', 'Telugu', 'Nepali', 'Punjabi',
    'Arabic', 'Portuguese', 'Russian', 'Spanish', 'French', 'German', 'Japanese', 'Korean', 'Chinese' // Added more for completeness
  ];

  static const List<String> difficultyLevels = [
    'Beginner', 'Novice', 'Intermediate', 'Proficient', 'Advanced',
    'Expert', 'Master', 'Grandmaster', 'Legendary', 'Mythic',
  ];

  static const List<String> educationLevels = [
    'Not Specified', 'High School', 'Associate Degree', 'Bachelor\'s Degree',
    'Master\'s Degree', 'Doctorate', 'Self-Taught',
  ];

  static const List<String> defaultCourseTopics = [
    'Artificial Intelligence', 'Machine Learning', 'Web Development (Frontend)',
    'Web Development (Backend)', 'Mobile App Development (Flutter)', 'Data Science',
    'Cybersecurity', 'Cloud Computing', 'Game Development', 'Database Management',
    'Network Engineering', 'DevOps', 'UI/UX Design', 'Digital Marketing',
    'Business Analytics', 'Project Management', 'Data Structures & Algorithms',
    'Operating Systems', 'Computer Networks', 'Software Engineering Principles',
    'Product Management', 'Financial Literacy', 'Personal Development',
    'Communication Skills', 'Critical Thinking', 'Problem Solving',
    'Creative Writing', 'History', 'Philosophy', 'Economics', 'Biology',
    'Chemistry', 'Physics', 'Mathematics', 'Art History', 'Music Theory',
  ];

  static const List<String> gameThemes = [
    'Fantasy', 'Sci-Fi', 'Adventure', 'Mystery', 'Cyberpunk', 'Space Exploration' // Added for flavor
  ];
}