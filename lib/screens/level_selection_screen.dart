// lib/screens/level_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/screens/lesson_screen.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/course.dart'; // Import Course model
import 'package:gamifier/models/level.dart';
import 'package:gamifier/models/lesson.dart'; // Import Lesson model
import 'package:gamifier/models/question.dart'; // Import Question model
import 'package:gamifier/models/user_profile.dart'; // Import UserProfile model
import 'package:gamifier/models/user_progress.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/services/gemini_api_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/gamification/level_node.dart';
import 'package:gamifier/widgets/gamification/level_path_painter.dart';
import 'dart:math'; // Import for max
import 'package:collection/collection.dart'; // Import for firstWhereOrNull

class LevelSelectionScreen extends StatefulWidget {
  final String courseId;
  final String courseTitle;

  const LevelSelectionScreen({
    super.key,
    required this.courseId,
    required this.courseTitle,
  });

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  late Stream<List<Level>> _levelsStream;
  late Stream<UserProgress?> _userProgressStream;
  UserProfile? _currentUserProfile;
  List<Level> _levels = [];
  bool _isLoadingMoreLevels = false;
  String? _errorMessage;
  final Map<String, Offset> _levelNodePositions = {}; // To store calculated top-left positions

  @override
  void initState() {
    super.initState();
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final currentUser = firebaseService.currentUser;

    if (currentUser != null) {
      _levelsStream = firebaseService.streamLevelsForCourse(widget.courseId);
      _levelsStream.listen((levels) {
        if (mounted) {
          setState(() {
            _levels = levels;
            // Only calculate positions after the first frame renders to get context width
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _calculateLevelNodePositions();
            });
          });
        }
      }).onError((e) {
        debugPrint('Error streaming levels: $e');
        if (mounted) {
          setState(() {
            _errorMessage = 'Failed to load levels: ${e.toString()}';
          });
        }
      });

      _userProgressStream = firebaseService.streamUserCourseProgress(currentUser.uid, widget.courseId);
      _userProgressStream.listen((progress) {
        if (mounted && progress != null) {
          debugPrint('User Progress Updated: ${progress.currentLevelId}');
        }
      }).onError((e) {
        debugPrint('Error streaming user progress: $e');
      });

      firebaseService.streamUserProfile(currentUser.uid).listen((profile) {
        if (mounted) {
          setState(() {
            _currentUserProfile = profile;
          });
        }
      });
    } else {
      _errorMessage = 'User not logged in. Please log in to view courses.';
    }
  }

  // Calculate positions for zigzag layout using a Stack
  void _calculateLevelNodePositions() {
    _levelNodePositions.clear();
    const double nodeSize = 120.0; // Width/Height of LevelNode
    const double verticalStep = 140.0; // Vertical distance between centers of nodes

    final double screenWidth = MediaQuery.of(context).size.width;
    // Adjusted these to better center the columns for any screen size
    final double leftColumnX = screenWidth * 0.2 - nodeSize / 2;
    final double rightColumnX = screenWidth * 0.8 - nodeSize / 2;

    for (int i = 0; i < _levels.length; i++) {
      final level = _levels[i];
      double x;
      double y = (i * verticalStep) + AppConstants.padding * 2; // Add top padding to start layout lower

      if (i % 2 == 0) {
        // Even index (0, 2, 4...), aligned to the left side
        x = leftColumnX;
      } else {
        // Odd index (1, 3, 5...), aligned to the right side
        x = rightColumnX;
      }
      _levelNodePositions[level.id] = Offset(x, y);
    }

    // Recalculate positions for the "Generate More Levels" button
    if (_levels.length < AppConstants.maxLevelsPerCourse) {
      final double lastNodeY = _levels.isNotEmpty
          ? _levelNodePositions[_levels.last.id]!.dy + verticalStep
          : AppConstants.padding * 2; // Position below the last node or initial padding
      final double centerX = screenWidth / 2 - nodeSize / 2; // Center the button
      _levelNodePositions['generate_more'] = Offset(centerX, lastNodeY);
    }
  }


  Future<void> _loadMoreLevels() async {
    if (_isLoadingMoreLevels || _levels.length >= AppConstants.maxLevelsPerCourse) {
      return;
    }

    setState(() {
      _isLoadingMoreLevels = true;
      _errorMessage = null;
    });

    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final geminiService = Provider.of<GeminiApiService>(context, listen: false);
    final currentUser = firebaseService.currentUser;

    if (currentUser == null) {
      setState(() {
        _errorMessage = 'User not logged in.';
        _isLoadingMoreLevels = false;
      });
      return;
    }

    try {
      final int nextStartingOrder = _levels.isNotEmpty ? _levels.last.order + 1 : 1;
      final int levelsToGenerate = (AppConstants.maxLevelsPerCourse - _levels.length).clamp(0, AppConstants.subsequentLevelsBatchSize);

      if (levelsToGenerate <= 0) {
        setState(() {
          _isLoadingMoreLevels = false;
        });
        return;
      }

      final List<Level> previousLevelsContext = _levels.sublist(
          _levels.length > 5 ? _levels.length - 5 : 0); // Provide last few levels for context

      final Map<String, dynamic> generatedData = await geminiService.generateSubsequentLevels(
        courseId: widget.courseId,
        topicName: widget.courseTitle,
        ageGroup: 'college student',
        domain: 'General Education',
        difficulty: 'Intermediate',
        startingLevelOrder: nextStartingOrder,
        numberOfLevels: levelsToGenerate,
        previousLevelsContext: previousLevelsContext,
      );

      List<Level> newLevels = (generatedData['levels'] as List).map((e) => Level.fromMap(e as Map<String, dynamic>)).toList();
      Map<String, List<Lesson>> lessonsPerLevel = {};
      (generatedData['lessonsPerLevel'] as Map).forEach((key, value) {
        lessonsPerLevel[key as String] = (value as List).map((e) => Lesson.fromMap(e as Map<String, dynamic>)).toList();
      });

      Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};
      (generatedData['questionsPerLessonPerLevel'] as Map).forEach((levelId, lessonMap) {
        questionsPerLessonPerLevel[levelId as String] = {};
        (lessonMap as Map).forEach((lessonId, questionList) {
          questionsPerLessonPerLevel[levelId]![lessonId as String] = (questionList as List).map((e) => Question.fromMap(e as Map<String, dynamic>)).toList();
        });
      });


      await firebaseService.saveLevels(newLevels, lessonsPerLevel, questionsPerLessonPerLevel);

      // Update the course with new level IDs
      final Course? existingCourse = await firebaseService.getCourse(widget.courseId);
      if (existingCourse != null) {
        final updatedCourse = existingCourse.copyWith(
          levelIds: [...?existingCourse.levelIds, ...newLevels.map((l) => l.id).toList()],
        );
        await firebaseService.updateCourse(widget.courseId, {'levelIds': updatedCourse.levelIds});
      }

      if (mounted) {
        setState(() {
          _levels.addAll(newLevels);
          _calculateLevelNodePositions(); // Recalculate positions after adding new levels
        });
      }
    } catch (e) {
      debugPrint('Error generating more levels: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to generate more levels: ${e.toString()}';
        });
      }
    } finally {
      setState(() {
        _isLoadingMoreLevels = false;
      });
    }
  }

  void _onLevelTapped(Level level, UserProgress? userProgress) async {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final currentUser = firebaseService.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to start a lesson.')),
      );
      return;
    }

    // Check if the level is unlocked (previous level completed, or it's the first level)
    final bool isPreviousLevelCompleted = level.order == 1 ||
        _levels.any((l) => l.order == level.order - 1 && (userProgress?.levelsProgress[l.id]?.isCompleted == true));

    if (!isPreviousLevelCompleted && level.order != 1 && (userProgress?.levelsProgress[level.id]?.isCompleted != true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This level is locked! Complete previous levels first.')),
      );
      return;
    }

    try {
      // Fetch the most up-to-date user progress
      UserProgress? latestUserProgress = await firebaseService.getUserCourseProgress(currentUser.uid, widget.courseId);
      Lesson? lessonToStart;

      // Determine which lesson to start within the level
      if (latestUserProgress != null &&
          latestUserProgress.currentLevelId == level.id &&
          latestUserProgress.currentLessonId != null) {
        // User is continuing this level, try to load current lesson
        lessonToStart = await firebaseService.getLesson(level.id, latestUserProgress.currentLessonId!);
        if (lessonToStart == null || (latestUserProgress.lessonsProgress[lessonToStart.id]?.isCompleted == true)) {
          // If current lesson is completed or not found, try to find the next uncompleted lesson
          final allLessonsInLevel = await firebaseService.getFirestore()
              .collection('levels')
              .doc(level.id)
              .collection('lessons')
              .orderBy('order')
              .get()
              .then((snapshot) => snapshot.docs.map((doc) => Lesson.fromMap(doc.data())).toList());

          lessonToStart = allLessonsInLevel.firstWhereOrNull(
            (lesson) => !(latestUserProgress?.lessonsProgress[lesson.id]?.isCompleted == true),
          );
        }
      }

      if (lessonToStart == null) {
        // If no progress, or no next uncompleted lesson found, start from the first lesson of the level
        final lessonsSnapshot = await firebaseService.getFirestore().collection('levels').doc(level.id).collection('lessons').orderBy('order').get();
        final lessons = lessonsSnapshot.docs.map((doc) => Lesson.fromMap(doc.data())).toList();
        if (lessons.isNotEmpty) {
          lessonToStart = lessons.first;
        } else {
          debugPrint('No lessons found for level ${level.id}.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No lessons available for this level. Please try another course.')),
          );
          return;
        }
      }

      if (lessonToStart != null) {
        // Update user progress to reflect the current level and lesson
        final String progressId = '${currentUser.uid}_${widget.courseId}';
        final updatedUserProgress = (latestUserProgress ?? UserProgress(
          id: progressId,
          userId: currentUser.uid,
          courseId: widget.courseId,
          currentLevelId: level.id,
          currentLessonId: lessonToStart.id,
        )).copyWith(
          currentLevelId: level.id,
          currentLessonId: lessonToStart.id,
          levelsProgress: Map.from(latestUserProgress?.levelsProgress ?? {})..putIfAbsent(level.id, () => const LevelProgress(isCompleted: false, xpEarned: 0, score: 0)),
          lessonsProgress: Map.from(latestUserProgress?.lessonsProgress ?? {})..putIfAbsent(lessonToStart.id, () => const LessonProgress(isCompleted: false, xpEarned: 0, questionAttempts: {})),
        );
        await firebaseService.saveUserProgress(updatedUserProgress);

        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LessonScreen(
                courseId: widget.courseId,
                levelId: level.id,
                lessonId: lessonToStart!.id,
                levelOrder: level.order,
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load lesson details. Please try again.')),
        );
      }
    } catch (e) {
      debugPrint('Error navigating to lesson: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load lesson: ${e.toString()}')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: widget.courseTitle,
        automaticallyImplyLeading: true, // Show back arrow
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(),
        ),
        child: SafeArea(
          child: StreamBuilder<UserProgress?>(
            stream: _userProgressStream,
            builder: (context, progressSnapshot) {
              final userProgress = progressSnapshot.data;

              final double contentHeight = (_levels.length * 140.0) + (AppConstants.padding * 4) + (_levels.length < AppConstants.maxLevelsPerCourse ? 150 : 0);

              return SingleChildScrollView(
                child: SizedBox(
                  height: max(contentHeight, MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top),
                  child: Stack(
                    children: [
                      // Draw zigzag lines
                      if (_levels.isNotEmpty && _levelNodePositions.isNotEmpty)
                        CustomPaint(
                          painter: LevelPathPainter(
                            levels: _levels,
                            levelPositions: _levelNodePositions,
                            levelCompletionStatus: {
                              for (var level in _levels)
                                level.id: userProgress?.levelsProgress[level.id]?.isCompleted == true,
                            },
                            nodeSize: 120.0, // Pass node size for path calculation
                          ),
                          child: Container(), // Empty container to provide paint area
                        ),

                      // Position LevelNodes
                      ..._levels.map((level) {
                        final int currentLevelIndex = _levels.indexOf(level);
                        final String? previousLevelId = currentLevelIndex > 0 ? _levels[currentLevelIndex - 1].id : null;
                        final bool isPreviousLevelCompleted = previousLevelId != null && (userProgress?.levelsProgress[previousLevelId]?.isCompleted == true);

                        final bool isLocked = level.order > 1 && !isPreviousLevelCompleted;

                        final Offset? position = _levelNodePositions[level.id];
                        if (position == null) return const SizedBox.shrink();

                        return Positioned(
                          left: position.dx,
                          top: position.dy,
                          child: LevelNode(
                            level: level,
                            isCompleted: userProgress?.levelsProgress[level.id]?.isCompleted == true, // Explicitly check completion status from userProgress
                            isLocked: isLocked,
                            onTap: () => _onLevelTapped(level, userProgress),
                          ),
                        );
                      }).toList(),

                      // Position "Generate More Levels" button
                      if (_levels.length < AppConstants.maxLevelsPerCourse)
                        Positioned(
                          left: _levelNodePositions['generate_more']?.dx,
                          top: _levelNodePositions['generate_more']?.dy,
                          child: GestureDetector(
                            onTap: _isLoadingMoreLevels ? null : _loadMoreLevels,
                            child: Card(
                              color: AppColors.cardColor.withOpacity(0.7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                                side: BorderSide(color: AppColors.borderColor.withOpacity(0.5), width: 1),
                              ),
                              child: Container(
                                width: 120, // Match node size
                                height: 120, // Match node size
                                padding: const EdgeInsets.all(AppConstants.padding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _isLoadingMoreLevels
                                        ? const CircularProgressIndicator(color: AppColors.accentColor)
                                        : Icon(
                                            Icons.add_circle_outline,
                                            color: AppColors.textColorSecondary.withOpacity(0.7),
                                            size: 50,
                                          ),
                                    const SizedBox(height: AppConstants.spacing),
                                    Text(
                                      _isLoadingMoreLevels ? 'Generating...' : 'Generate More Levels',
                                      style: TextStyle(color: AppColors.textColorSecondary.withOpacity(0.9), fontSize: 12), // Smaller font
                                      textAlign: TextAlign.center,
                                    ),
                                    if (_errorMessage != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: AppConstants.spacing),
                                        child: Text(
                                          _errorMessage!,
                                          style: const TextStyle(color: AppColors.errorColor, fontSize: 10),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}