// lib/constants/app_constants.dart
import 'package:flutter/material.dart';
import 'package:gamifier/models/avatar_asset.dart';

class AppConstants {
  static const String appName = 'Gamifier';

  // API Keys
  static const String geminiApiKey = 'AIzaSyDZ6yDuQgQWxzc5Qq24Dpf_BkvcOjx_SP8'; // Replace with your actual Gemini API Key
  static const String appTagline = 'Learn. Play. Conquer.';
  // Firestore Collection Names
  static const String usersCollection = 'users';
  static const String coursesCollection = 'courses';
  static const String levelsCollection = 'levels';
  static const String lessonsCollection = 'lessons'; // Subcollection under levels
  static const String questionsCollection = 'questions'; // Subcollection under lessons
  static const String userProgressCollection = 'userProgress';
  static const String badgesCollection = 'badges';
  static const String communityPostsCollection = 'communityPosts';
  static const String chatMessagesCollection = 'chatMessages';

  // App theming and UI
  static const double padding = 16.0;
  static const double spacing = 8.0;
  static const double borderRadius = 12.0;
  static const double iconSize = 24.0;
  static const double avatarSize = 60.0;
  static const double badgeSize = 80.0;
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  // Gamification Constants
  static const int initialXp = 0;
  static const int xpPerLevel = 100;
  static const int leaderboardLimit = 10;
  static const int minStreakDaysForBonus = 3;
  static const int streakBonusXp = 20;

  // Course Generation Constants
  static const int initialLevelsCount = 5; // Generate first 5 levels
  static const int subsequentLevelsBatchSize = 5; // Generate 5 more levels at a time
  static const int maxLevelsPerCourse = 15; // Max total levels

  // UI specific constants
  static const double levelSelectionGenerateButtonHeight = 150.0; // Added for LevelSelectionScreen height calculation

  // Default Content for Placeholders/Initial Data
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

  // Added supportedLanguages for course creation
  static const List<String> supportedLanguages = [
    'English',
    'Hindi',
    'Marathi',
    'Bengali',
    'Telugu',
    'Nepali',
    'Punjabi',
    'Arabic',
    'Portuguese',
    'Russian',
  ];

  // Removed gameThemes as it's no longer used for new course generation.
  // static const List<String> gameThemes = [...]; // This line is removed

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
    'Not Specified', // Added for flexibility
    'High School',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Doctorate',
    'Self-Taught',
  ];

  static const List<String> defaultCourseTopics = [
    'Artificial Intelligence',
    'Machine Learning',
    'Web Development (Frontend)',
    'Web Development (Backend)',
    'Mobile App Development (Flutter)',
    'Data Science',
    'Cybersecurity',
    'Cloud Computing',
    'Game Development',
    'Database Management',
    'Network Engineering',
    'DevOps',
    'UI/UX Design',
    'Digital Marketing',
    'Business Analytics',
    'Project Management',
    'Data Structures & Algorithms',
    'Operating Systems',
    'Computer Networks',
    'Software Engineering Principles',
    'Product Management',
    'Financial Literacy',
    'Personal Development',
    'Communication Skills',
    'Critical Thinking',
    'Problem Solving',
    'Creative Writing',
    'History',
    'Philosophy',
    'Economics',
    'Biology',
    'Chemistry',
    'Physics',
    'Mathematics',
    'Art History',
    'Music Theory',
  ];
  // Keeping gameThemes for existing Course model data and potential future use,
  // but it will no longer be used in the CourseCreationScreen.
  static const List<String> gameThemes = [
    'Fantasy',
    'Sci-Fi',
    'Adventure',
    'Mystery',
    'Cyberpunk',
  ];
}
