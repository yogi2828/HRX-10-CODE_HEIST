// lib/screens/lesson_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/lesson.dart';
import 'package:gamifier/models/level.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/models/user_progress.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/services/audio_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/utils/validation_utils.dart';
import 'package:gamifier/widgets/common/custom_app_bar.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/common/progress_bar.dart';
import 'package:gamifier/widgets/feedback/personalized_feedback_modal.dart';
import 'package:gamifier/widgets/lesson/lesson_content_display.dart';
import 'package:gamifier/widgets/questions/question_renderer.dart';
import 'package:gamifier/widgets/navigation/bottom_nav_bar.dart'; // Import BottomNavBar

class LessonScreen extends StatefulWidget {
  final String courseId;
  final String levelId;
  final String lessonId;
  final int levelOrder;

  const LessonScreen({
    super.key,
    required this.courseId,
    required this.levelId,
    required this.lessonId,
    required this.levelOrder,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  Lesson? _currentLesson;
  Level? _currentLevel;
  List<Question> _questions = [];
  UserProgress? _userProgress;
  int _currentQuestionIndex = 0;
  bool _isLoading = true;
  String? _errorMessage;
  Map<String, String> _userAnswers = {};
  Map<String, bool> _questionAttemptStatus = {};
  Map<String, int> _xpAwardedPerQuestion = {};

  late FirebaseService _firebaseService;
  late AudioService _audioService;

  @override
  void initState() {
    super.initState();
    _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    _audioService = Provider.of<AudioService>(context, listen: false);
    _loadLessonAndProgress();
  }

  Future<void> _loadLessonAndProgress() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = _firebaseService.currentUser;
      if (user == null) {
        setState(() {
          _errorMessage = 'User not logged in.';
          _isLoading = false;
        });
        return;
      }

      final lesson = await _firebaseService.getLesson(widget.levelId, widget.lessonId);
      final level = await _firebaseService.getLevel(widget.levelId);
      final questions = await _firebaseService.getLessonQuestions(widget.levelId, widget.lessonId);
      final userProgress = await _firebaseService.getUserCourseProgress(user.uid, widget.courseId);

      if (lesson == null || level == null) {
        setState(() {
          _errorMessage = 'Lesson or Level not found.';
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _currentLesson = lesson;
        _currentLevel = level;
        _questions = questions;
        _userProgress = userProgress ?? UserProgress(
          id: '${user.uid}_${widget.courseId}',
          userId: user.uid,
          courseId: widget.courseId,
          currentLevelId: widget.levelId,
          currentLessonId: widget.lessonId,
        );

        // Restore user answers and question attempt status if available in progress
        final lessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id];
        if (lessonProgress != null) {
          _currentQuestionIndex = lessonProgress.questionAttempts.length;
          lessonProgress.questionAttempts.forEach((questionId, attempt) {
            _questionAttemptStatus[questionId] = attempt.isCorrect;
            _userAnswers[questionId] = attempt.userAnswer;
            _xpAwardedPerQuestion[questionId] = attempt.xpAwarded;
          });
        }
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading lesson or progress: $e');
      setState(() {
        _errorMessage = 'Failed to load lesson content: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _submitAnswer(String questionId, String userAnswer, String questionType, dynamic correctAnswerData) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    final firebaseUser = _firebaseService.currentUser;
    if (firebaseUser == null || _currentLesson == null || _userProgress == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'User not logged in or lesson/progress data missing.';
      });
      return;
    }

    // Ensure correctAnswerData is a String, defaulting to empty if null
    String validationCorrectAnswer = '';
    if (correctAnswerData != null) {
      validationCorrectAnswer = correctAnswerData.toString();
    }

    final bool isCorrect = ValidationUtils.validateAnswer(userAnswer, questionType, validationCorrectAnswer);
    final int xpAwarded = isCorrect ? _questions[_currentQuestionIndex].xpReward : 0;

    // Only play correct sound if the answer is correct
    if (isCorrect) {
      _audioService.playCorrectSound();
    }

    setState(() {
      _userAnswers[questionId] = userAnswer;
      _questionAttemptStatus[questionId] = isCorrect;
      _xpAwardedPerQuestion[questionId] = xpAwarded;
    });

    // Update user progress
    LessonProgress currentLessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id] ??
        const LessonProgress(isCompleted: false, xpEarned: 0, questionAttempts: {});

    final updatedQuestionAttempts = Map<String, QuestionAttempt>.from(currentLessonProgress.questionAttempts);
    updatedQuestionAttempts[questionId] = QuestionAttempt(
      userAnswer: userAnswer,
      isCorrect: isCorrect,
      attemptedAt: DateTime.now(),
      xpAwarded: xpAwarded,
    );

    currentLessonProgress = currentLessonProgress.copyWith(
      xpEarned: (currentLessonProgress.xpEarned ?? 0) + xpAwarded, // Ensure xpEarned is not null
      questionAttempts: updatedQuestionAttempts,
    );

    Map<String, LessonProgress> updatedLessonsProgress = Map.from(_userProgress!.lessonsProgress);
    updatedLessonsProgress[_currentLesson!.id] = currentLessonProgress;

    await _firebaseService.addXp(firebaseUser.uid, xpAwarded);

    _userProgress = _userProgress!.copyWith(
      lessonsProgress: updatedLessonsProgress,
    );
    await _firebaseService.saveUserProgress(_userProgress!);

    setState(() {
      _isLoading = false;
    });

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => PersonalizedFeedbackModal(
        isCorrect: isCorrect,
        userAnswer: userAnswer,
        questionText: _questions[_currentQuestionIndex].questionText,
        correctAnswer: validationCorrectAnswer, // Pass the non-null string
        lessonContent: _currentLesson!.content,
        userProgress: _userProgress!,
      ),
    );

    _goToNextQuestion();
  }

  void _goToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _markLessonCompleted();
      }
    });
  }

  Future<void> _markLessonCompleted() async {
    final firebaseUser = _firebaseService.currentUser;
    if (firebaseUser == null || _currentLesson == null || _userProgress == null) {
      return;
    }

    LessonProgress currentLessonProgress = _userProgress!.lessonsProgress[_currentLesson!.id] ??
        const LessonProgress(isCompleted: false, xpEarned: 0, questionAttempts: {});

    if (!currentLessonProgress.isCompleted) {
      currentLessonProgress = currentLessonProgress.copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      );

      Map<String, LessonProgress> updatedLessonsProgress = Map.from(_userProgress!.lessonsProgress);
      updatedLessonsProgress[_currentLesson!.id] = currentLessonProgress;

      _userProgress = _userProgress!.copyWith(
        lessonsProgress: updatedLessonsProgress,
      );
      await _firebaseService.saveUserProgress(_userProgress!);
    }

    // Check if current level is completed
    List<Lesson> allLessonsInLevel = [];
    final levelRef = _firebaseService.getFirestore().collection(AppConstants.levelsCollection).doc(widget.levelId);
    final lessonsSnapshot = await levelRef.collection('lessons').orderBy('order').get();
    allLessonsInLevel = lessonsSnapshot.docs.map((doc) => Lesson.fromMap(doc.data())).toList();

    bool allLessonsCompletedInLevel = allLessonsInLevel.every((lesson) {
      return _userProgress!.lessonsProgress[lesson.id]?.isCompleted == true;
    });

    if (allLessonsCompletedInLevel) {
      int totalXpEarnedInLevel = allLessonsInLevel.fold(0, (sum, lesson) => sum + (_userProgress!.lessonsProgress[lesson.id]?.xpEarned ?? 0));

      LevelProgress currentLevelProgress = _userProgress!.levelsProgress[widget.levelId] ??
          const LevelProgress(isCompleted: false, xpEarned: 0, score: 0);

      currentLevelProgress = currentLevelProgress.copyWith(
        isCompleted: true,
        xpEarned: (currentLevelProgress.xpEarned ?? 0) + totalXpEarnedInLevel, // Ensure xpEarned is not null
        score: (totalXpEarnedInLevel / (allLessonsInLevel.length * 15 * _questions.length)).round(), // Rough score calculation
        completedAt: DateTime.now(),
      );

      Map<String, LevelProgress> updatedLevelsProgress = Map.from(_userProgress!.levelsProgress);
      updatedLevelsProgress[widget.levelId] = currentLevelProgress;

      _userProgress = _userProgress!.copyWith(
        currentLevelId: null, // Reset current level as it's completed
        currentLessonId: null, // Reset current lesson as it's completed
        levelsProgress: updatedLevelsProgress,
      );
      await _firebaseService.saveUserProgress(_userProgress!);

      // Check if course is completed
      List<Level> allLevelsInCourse = [];
      final courseLevelsSnapshot = await _firebaseService.getFirestore()
          .collection(AppConstants.levelsCollection)
          .where('courseId', isEqualTo: widget.courseId)
          .orderBy('order')
          .get();
      allLevelsInCourse = courseLevelsSnapshot.docs.map((doc) => Level.fromMap(doc.data())).toList();

      bool allLevelsCompletedInCourse = allLevelsInCourse.every((level) {
        return _userProgress!.levelsProgress[level.id]?.isCompleted == true;
      });

      if (mounted) {
        Navigator.of(context).pushReplacementNamed(
          AppRouter.levelCompletionRoute,
          arguments: {
            'courseId': widget.courseId,
            'levelId': widget.levelId,
            'xpEarned': totalXpEarnedInLevel,
            'isCourseCompleted': allLevelsCompletedInCourse,
          },
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lesson completed! Continue to the next lesson or level.'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.of(context).pop(); // Go back to level selection
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: _currentLevel?.title ?? 'Lesson',
        subtitle: _currentLesson?.title,
        automaticallyImplyLeading: true, // Allow back to level selection
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.of(context).pop(), // Pops to LevelSelectionScreen
        // ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
              : _errorMessage != null
                  ? Center(child: Text(_errorMessage!, style: const TextStyle(color: AppColors.errorColor)))
                  : Padding(
                      padding: const EdgeInsets.all(AppConstants.padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProgressBar(
                            current: _currentQuestionIndex,
                            total: _questions.length,
                          ),
                          const SizedBox(height: AppConstants.spacing * 2),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    color: AppColors.cardColor.withOpacity(0.9),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(AppConstants.padding),
                                      child: LessonContentDisplay(content: _currentLesson!.content),
                                    ),
                                  ),
                                  const SizedBox(height: AppConstants.spacing * 2),
                                  if (_questions.isNotEmpty && _currentQuestionIndex < _questions.length)
                                    QuestionRenderer(
                                      question: _questions[_currentQuestionIndex],
                                      onSubmit: (userAnswer) {
                                        // Ensure the correctAnswerData passed is never null
                                        dynamic dataToSend;
                                        switch (_questions[_currentQuestionIndex].type) {
                                          case 'MCQ':
                                          case 'FillInBlank':
                                            dataToSend = _questions[_currentQuestionIndex].correctAnswer;
                                            break;
                                          case 'ShortAnswer':
                                            dataToSend = _questions[_currentQuestionIndex].expectedAnswerKeywords;
                                            break;
                                          case 'Scenario':
                                            dataToSend = _questions[_currentQuestionIndex].expectedOutcome;
                                            break;
                                          default:
                                            dataToSend = ''; // Default for unknown types
                                        }

                                        _submitAnswer(
                                          _questions[_currentQuestionIndex].id,
                                          userAnswer,
                                          _questions[_currentQuestionIndex].type,
                                          dataToSend ?? '', // Ensure it's never null
                                        );
                                      },
                                      isSubmitted: _questionAttemptStatus.containsKey(_questions[_currentQuestionIndex].id),
                                      lastUserAnswer: _userAnswers[_questions[_currentQuestionIndex].id],
                                      isLastAttemptCorrect: _questionAttemptStatus[_questions[_currentQuestionIndex].id],
                                      xpAwarded: _xpAwardedPerQuestion[_questions[_currentQuestionIndex].id],
                                    )
                                  else if (_questions.isEmpty)
                                    const Center(
                                      child: Text(
                                        'No questions for this lesson yet. Please try again later.',
                                        style: TextStyle(color: AppColors.textColorSecondary),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (_currentQuestionIndex == _questions.length)
                            Padding(
                              padding: const EdgeInsets.only(top: AppConstants.padding),
                              child: CustomButton(
                                onPressed: _markLessonCompleted,
                                text: 'Finish Lesson',
                                icon: Icons.flag,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0), // Default to home in bottom nav
    );
  }
}