// lib/screens/lesson_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/lesson.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/models/user_progress.dart';
import 'package:gamifier/services/audio_service.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/services/gemini_api_service.dart'; // New for adaptive learning and multimedia
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';
import 'package:gamifier/widgets/common/progress_bar.dart';
import 'package:gamifier/widgets/questions/question_renderer.dart';
import 'package:gamifier/widgets/feedback/personalized_feedback_modal.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart'; // For rendering SVG/HTML

class LessonScreen extends StatefulWidget {
  final String courseId;
  final String levelId;

  const LessonScreen({super.key, required this.courseId, required this.levelId});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  Lesson? _currentLesson;
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  bool _isLoading = true;
  UserProfile? _userProfile;
  UserProgress? _userProgress;
  int _xpEarnedInLesson = 0;
  int _currentXp = 0;
  int _currentLevel = 0;
  String _svgContent = ''; // New: For AI-generated SVG

  @override
  void initState() {
    super.initState();
    _fetchLessonAndQuestions();
  }

  Future<void> _fetchLessonAndQuestions() async {
    setState(() {
      _isLoading = true;
    });
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
    final currentUser = firebaseService.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated.', style: TextStyle(color: AppColors.errorColor))),
      );
      Navigator.of(context).pop();
      return;
    }

    try {
      _userProfile = await firebaseService.streamUserProfile(currentUser.uid).first;
      _currentXp = _userProfile?.xp ?? 0;
      _currentLevel = _userProfile?.level ?? 1;

      // Fetch or create UserProgress for this course
      _userProgress = await firebaseService.streamUserProgress(currentUser.uid, widget.courseId).first;
      if (_userProgress == null) {
        _userProgress = UserProgress(
          id: const Uuid().v4(),
          userId: currentUser.uid,
          courseId: widget.courseId,
          currentLevelId: widget.levelId,
          currentLessonId: '', // Will be set after first lesson is loaded
          lessonsProgress: {},
        );
        await firebaseService.saveUserProgress(_userProgress!);
      } else {
        // Ensure currentLevelId is set if user progress exists but isn't on this level
        if (_userProgress!.currentLevelId != widget.levelId) {
          _userProgress = _userProgress!.copyWith(currentLevelId: widget.levelId);
          await firebaseService.updateUserProgress(_userProgress!);
        }
      }

      // Determine current lesson
      final allLevels = await firebaseService.getLevelsForCourse(widget.courseId);
      final currentLevelObj = allLevels.firstWhere((level) => level.id == widget.levelId);
      final lessonsForLevel = await firebaseService.getLessonsForLevel(currentLevelObj.id);
      lessonsForLevel.sort((a, b) => a.id.compareTo(b.id)); // Simple sorting, consider adding an 'order' field to Lesson model if complex ordering is needed.

      String? lessonToLoadId;
      if (_userProgress!.currentLessonId != null && _userProgress!.currentLessonId!.isNotEmpty) {
        lessonToLoadId = _userProgress!.currentLessonId;
      } else {
        // Find the first uncompleted lesson
        for (final lesson in lessonsForLevel) {
          if (!(_userProgress!.lessonsProgress[lesson.id]?.isCompleted ?? false)) {
            lessonToLoadId = lesson.id;
            break;
          }
        }
        // If all lessons are completed in this level, this might be an issue or imply level completion logic elsewhere
        if (lessonToLoadId == null && lessonsForLevel.isNotEmpty) {
          lessonToLoadId = lessonsForLevel.last.id; // Or navigate to level completion
        }
      }

      if (lessonToLoadId != null) {
        _currentLesson = await firebaseService.getLesson(lessonToLoadId);
        if (_currentLesson != null) {
          _questions = await firebaseService.getQuestionsForLesson(_currentLesson!.id);
          _questions.shuffle(); // Randomize question order

          // Update currentLessonId in user progress
          _userProgress = _userProgress!.copyWith(currentLessonId: _currentLesson!.id);
          await firebaseService.updateUserProgress(_userProgress!);

          // Generate SVG content if lesson title indicates a diagram might be useful
          if (_currentLesson!.title.toLowerCase().contains('flow') || _currentLesson!.title.toLowerCase().contains('diagram')) {
             _svgContent = await geminiApiService.generateSvgContent(_currentLesson!.title);
          }
        }
      }

      if (_currentLesson == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No lessons found for this level.', style: TextStyle(color: AppColors.warningColor))),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Error loading lesson and questions: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load lesson: ${e.toString()}', style: const TextStyle(color: AppColors.errorColor))),
      );
      Navigator.of(context).pop();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onAnswerSubmitted(bool isCorrect, int xpAwarded, String? feedback) async {
    final audioService = Provider.of<AudioService>(context, listen: false);
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final geminiApiService = Provider.of<GeminiApiService>(context, listen: false); // For adaptive learning
    final currentUser = firebaseService.currentUser;

    if (currentUser == null || _userProgress == null || _currentLesson == null) return;

    if (isCorrect) {
      audioService.playLocalAsset(AppConstants.correctSoundPath);
      setState(() {
        _xpEarnedInLesson += xpAwarded;
        _currentXp += xpAwarded;
      });
      await firebaseService.addXp(currentUser.uid, xpAwarded);
      // Mark question as completed in user progress
      _userProgress!.lessonsProgress.putIfAbsent(_currentLesson!.id, () => LessonProgress(lessonId: _currentLesson!.id));
      _userProgress!.lessonsProgress[_currentLesson!.id]!.completedQuestions.add(_questions[_currentQuestionIndex].id);
    } else {
      audioService.playLocalAsset(AppConstants.incorrectSoundPath);
      // Deduct XP for incorrect answers on reattempt if configured
      if (_userProgress!.lessonsProgress[_currentLesson!.id]?.attempts[_questions[_currentQuestionIndex].id] != null) {
        setState(() {
          _currentXp -= AppConstants.levelXpDeductionOnReattempt;
        });
        await firebaseService.addXp(currentUser.uid, -AppConstants.levelXpDeductionOnReattempt);
      }
    }

    // Increment attempt count for the question
    _userProgress!.lessonsProgress[_currentLesson!.id]?.attempts[_questions[_currentQuestionIndex].id] =
        (_userProgress!.lessonsProgress[_currentLesson!.id]?.attempts[_questions[_currentQuestionIndex].id] ?? 0) + 1;

    // Update performance score for the lesson (simple average of correct answers for now)
    final lessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id]!;
    final totalQuestionsInLesson = _questions.length;
    final correctQuestions = lessonProgress.completedQuestions.length;
    lessonProgress.performanceScore = totalQuestionsInLesson > 0 ? correctQuestions / totalQuestionsInLesson : 0.0;


    // Show personalized feedback
    if (feedback != null && feedback.isNotEmpty) {
      await showDialog(
        context: context,
        builder: (context) => PersonalizedFeedbackModal(feedback: feedback, isCorrect: isCorrect),
      );
    }

    await firebaseService.updateUserProgress(_userProgress!);

    // Check for level up after XP update
    final newLevel = (_currentXp ~/ AppConstants.xpPerLevel) + 1;
    if (newLevel > _currentLevel) {
      setState(() {
        _currentLevel = newLevel;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('LEVEL UP! You are now Level $newLevel!', style: const TextStyle(color: AppColors.levelColor))),
      );
      audioService.playLocalAsset(AppConstants.levelUpSoundPath);
    }

    _nextQuestionOrCompleteLesson();
  }

  void _nextQuestionOrCompleteLesson() async {
    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
    final currentUser = firebaseService.currentUser;

    if (currentUser == null || _userProgress == null || _currentLesson == null) return;

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // All questions completed for this lesson
      _userProgress!.lessonsProgress[_currentLesson!.id]?.isCompleted = true;
      await firebaseService.updateUserProgress(_userProgress!);

      // Adaptive Learning Path Suggestion
      final lessonPerformance = _userProgress!.lessonsProgress[_currentLesson!.id]?.performanceScore ?? 0.0;
      final suggestion = await geminiApiService.suggestNextLesson(
        currentUser.uid,
        widget.courseId,
        widget.levelId,
        lessonPerformance,
      );

      final nextAction = suggestion['nextAction'];
      final suggestionText = suggestion['suggestionText'];
      String? suggestedLessonId = suggestion['suggestedLessonId']; // AI provides a placeholder, we'll need to map this

      // Display AI suggestion
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.cardColor,
          title: const Text('AI Learning Suggestion'),
          content: Text(suggestionText, style: const TextStyle(color: AppColors.textColorSecondary)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(color: AppColors.accentColor)),
            ),
          ],
        ),
      );


      // Check if all lessons in the level are completed
      final allLevels = await firebaseService.getLevelsForCourse(widget.courseId);
      final currentLevelObj = allLevels.firstWhere((level) => level.id == widget.levelId);
      final lessonsForLevel = await firebaseService.getLessonsForLevel(currentLevelObj.id);
      lessonsForLevel.sort((a, b) => a.id.compareTo(b.id)); // Sort to get consistent next lesson logic

      bool allLessonsCompletedInLevel = true;
      for (final lesson in lessonsForLevel) {
        if (!(_userProgress!.lessonsProgress[lesson.id]?.isCompleted ?? false)) {
          allLessonsCompletedInLevel = false;
          break;
        }
      }

      if (allLessonsCompletedInLevel) {
        // Mark level as completed in user progress
        _userProgress = _userProgress!.copyWith(levelsCompleted: [..._userProgress!.levelsCompleted, widget.levelId]);
        await firebaseService.updateUserProgress(_userProgress!);

        // Determine if course is completed
        final course = await firebaseService.getCourse(widget.courseId);
        bool allLevelsCompletedInCourse = true;
        if (course != null) {
          final courseLevels = await firebaseService.getLevelsForCourse(widget.courseId);
          for (final level in courseLevels) {
            if (!_userProgress!.levelsCompleted.contains(level.id)) {
              allLevelsCompletedInCourse = false;
              break;
            }
          }
        }

        if (allLevelsCompletedInCourse) {
          // Navigate to Course Completion Screen
          Navigator.of(context).pushReplacementNamed(
            AppRouter.courseCompletionRoute,
            arguments: {
              'courseTitle': course?.title ?? 'Course', // Replace with actual course title
              'totalXpEarned': _xpEarnedInLesson,
              'newBadgesEarned': 0, // Placeholder
            },
          );
        } else {
          // Navigate to Level Completion Screen
          Navigator.of(context).pushReplacementNamed(
            AppRouter.levelCompletionRoute,
            arguments: {
              'levelTitle': currentLevelObj.title, // Pass actual level title
              'xpEarned': _xpEarnedInLesson,
              'newLevel': _currentLevel,
            },
          );
        }
      } else {
        // Navigate to the next lesson in the level (or adaptive path)
        Lesson? nextLesson;
        if (nextAction == 'nextLesson' || nextAction == 'advancedTopic' || nextAction == 'remedialLesson') {
          // Attempt to find the suggested lesson by ID first
          if (suggestedLessonId != null) {
            nextLesson = lessonsForLevel.firstWhereOrNull((l) => l.id == suggestedLessonId);
          }

          // Fallback if AI suggested ID is not valid or if action is just 'nextLesson' without specific ID
          if (nextLesson == null) {
            final currentLessonIndex = lessonsForLevel.indexWhere((lesson) => lesson.id == _currentLesson!.id);
            if (currentLessonIndex != -1 && currentLessonIndex < lessonsForLevel.length - 1) {
              nextLesson = lessonsForLevel[currentLessonIndex + 1];
            }
          }
        } else if (nextAction == 'reviewLevel') {
          // Stay on current level, perhaps navigate to the first uncompleted lesson of this level
          nextLesson = lessonsForLevel.firstWhereOrNull((l) => !(_userProgress!.lessonsProgress[l.id]?.isCompleted ?? false));
          nextLesson ??= lessonsForLevel.first; // Fallback to first lesson if all completed
        }

        if (nextLesson != null) {
          _userProgress = _userProgress!.copyWith(currentLessonId: nextLesson.id);
          await firebaseService.updateUserProgress(_userProgress!);
          Navigator.of(context).pushReplacementNamed(
            AppRouter.lessonRoute,
            arguments: {'courseId': widget.courseId, 'levelId': widget.levelId},
          );
        } else {
          // If no specific next lesson found, go back to level selection
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: CustomAppBar(
          title: _currentLesson?.title ?? 'Lesson',
        ),
        body: _isLoading
            ? const LoadingIndicator()
            : _currentLesson == null || _questions.isEmpty
                ? Center(
                    child: Text(
                      'No content or questions found for this lesson.',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textColorSecondary),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppConstants.padding),
                        child: ProgressBar(
                          current: _currentQuestionIndex + 1,
                          total: _questions.length,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(AppConstants.padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                color: AppColors.cardColor,
                                margin: const EdgeInsets.only(bottom: AppConstants.padding),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppConstants.padding),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _currentLesson!.content,
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
                                      ),
                                      if (_svgContent.isNotEmpty) ...[
                                        const SizedBox(height: AppConstants.padding),
                                        Text(
                                          'AI-Generated Diagram:',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
                                        ),
                                        const SizedBox(height: AppConstants.spacing),
                                        // Render SVG content
                                        HtmlWidget(
                                          _svgContent,
                                          // Other configurations for flutter_widget_from_html_core if needed
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppConstants.padding),
                              Text(
                                'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textColor),
                              ),
                              const SizedBox(height: AppConstants.spacing),
                              QuestionRenderer(
                                question: _questions[_currentQuestionIndex],
                                onSubmit: _onAnswerSubmitted,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

// Extension to help with firstWhereOrNull (similar to collection methods in other languages)
extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
