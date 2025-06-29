// lib/screens/course_creation_screen.dart
import 'package:flutter/material.dart';
import 'package:gamifier/widgets/navigation/top_nav_bar.dart'; // Changed to TopNavBar
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/course.dart';
import 'package:gamifier/models/level.dart';
import 'package:gamifier/models/lesson.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/services/gemini_api_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/course/course_form.dart';
import 'package:gamifier/utils/file_picker_util.dart';
import 'package:gamifier/widgets/common/night_sky_background.dart'; // Import NightSkyBackground

class CourseCreationScreen extends StatefulWidget {
  const CourseCreationScreen({super.key});

  @override
  State<CourseCreationScreen> createState() => _CourseCreationScreenState();
}

class _CourseCreationScreenState extends State<CourseCreationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _topicName = '';
  String _domain = '';
  String _difficulty = AppConstants.difficultyLevels[0];
  String _educationLevel = AppConstants.educationLevels[0];
  String _language = AppConstants.supportedLanguages[0]; // Changed from _gameGenre
  String _sourceContent = '';
  String _youtubeUrl = '';
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _pickFile() async {
    final content = await FilePickerUtil.pickTextFile();
    if (content != null) {
      setState(() {
        _sourceContent = content;
      });
    }
  }

  Future<void> _createCourse() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (_sourceContent.isEmpty && _youtubeUrl.isEmpty && _topicName.isEmpty) {
      setState(() {
        _errorMessage = 'Please provide a Topic Name or Source Content/YouTube URL.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final firebaseService = Provider.of<FirebaseService>(context, listen: false);
    final geminiService = Provider.of<GeminiApiService>(context, listen: false);
    final currentUser = firebaseService.currentUser;

    if (currentUser == null) {
      setState(() {
        _errorMessage = 'You must be logged in to create a course.';
        _isLoading = false;
      });
      return;
    }

    try {
      final String newCourseId = firebaseService.generateNewDocId();

      final Map<String, dynamic> generatedData = await geminiService.generateCourseContent(
        topicName: _topicName.isNotEmpty ? _topicName : 'Dynamic Course',
        ageGroup: 'college student',
        domain: _domain.isNotEmpty ? _domain : 'General Education',
        difficulty: _difficulty,
        educationLevel: _educationLevel,
        specialty: _domain,
        language: _language, // Pass the selected language
        sourceContent: _sourceContent.isNotEmpty ? _sourceContent : null,
        youtubeUrl: _youtubeUrl.isNotEmpty ? _youtubeUrl : null,
        numberOfLevels: AppConstants.initialLevelsCount,
      );

      Course newCourse = Course(
        id: newCourseId,
        title: generatedData['courseTitle'] as String,
        description: 'A dynamically generated course on ${generatedData['courseTitle']}.',
        gameGenre: generatedData['gameGenre'] as String?, // Still read gameGenre from model if present
        language: generatedData['language'] as String, // Read language from generated data
        difficulty: generatedData['difficulty'] as String,
        creatorId: currentUser.uid,
        createdAt: DateTime.now(),
      );

      List<Level> levelsToSave = [];
      Map<String, List<Lesson>> lessonsPerLevel = {};
      Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};

      if (generatedData['levels'] is List) { // Robust check for levels list
        for (var levelData in generatedData['levels']) {
          if (levelData is Map<String, dynamic>) { // Ensure each level item is a map
            final level = Level.fromMap(levelData);
            level.courseId = newCourseId;
            levelsToSave.add(level);

            List<Lesson> lessonsForThisLevel = [];
            Map<String, List<Question>> questionsForThisLevelLessons = {};

            if (levelData['lessons'] is List) { // Robust check for lessons list
              for (var lessonData in (levelData['lessons'] as List)) {
                if (lessonData is Map<String, dynamic>) { // Ensure each lesson item is a map
                  final lesson = Lesson.fromMap(lessonData);
                  lesson.levelId = level.id;
                  lessonsForThisLevel.add(lesson);

                  List<Question> questionsForThisLesson = [];
                  if (lessonData['questions'] is List) { // Robust check for questions list
                    for (var questionData in (lessonData['questions'] as List)) {
                      if (questionData is Map<String, dynamic>) { // Ensure each question item is a map
                        questionsForThisLesson.add(Question.fromMap(questionData));
                      } else {
                        debugPrint('Warning: Skipping malformed question data: $questionData');
                      }
                    }
                  }
                  questionsForThisLevelLessons[lesson.id] = questionsForThisLesson;
                } else {
                  debugPrint('Warning: Skipping malformed lesson data: $lessonData');
                }
              }
            }
            lessonsPerLevel[level.id] = lessonsForThisLevel;
            questionsPerLessonPerLevel[level.id] = questionsForThisLevelLessons;
          } else {
            debugPrint('Warning: Skipping malformed level data: $levelData');
          }
        }
      }


      newCourse = newCourse.copyWith(levelIds: levelsToSave.map((l) => l.id).toList());

      await firebaseService.saveCourse(newCourse);
      await firebaseService.saveLevels(levelsToSave, lessonsPerLevel, questionsPerLessonPerLevel);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course created successfully!')),
        );
        Navigator.of(context).pushReplacementNamed(AppRouter.levelSelectionRoute, arguments: {
          'courseId': newCourse.id,
          'courseTitle': newCourse.title,
        });
      }
    } catch (e) {
      debugPrint('Error creating course: $e');
      setState(() {
        _errorMessage = 'Failed to create course: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopNavBar( // Replaced CustomAppBar
        currentIndex: 4,
        title: 'Create New Course',
      ),
      body: NightSkyBackground( // Wrap content with NightSkyBackground
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CourseForm(
                    onTopicChanged: (value) => _topicName = value,
                    onDomainChanged: (value) => _domain = value,
                    onDifficultyChanged: (value) => setState(() => _difficulty = value!),
                    onEducationLevelChanged: (value) => setState(() => _educationLevel = value!),
                    onLanguageChanged: (value) => setState(() => _language = value!), // Changed here
                    onYoutubeUrlChanged: (value) => _youtubeUrl = value,
                    onSourceContentChanged: (value) => _sourceContent = value,
                    currentDifficulty: _difficulty,
                    currentEducationLevel: _educationLevel,
                    currentLanguage: _language, // Changed here
                  ),
                  const SizedBox(height: AppConstants.spacing * 2),
                  CustomButton(
                    onPressed: _pickFile,
                    text: 'Upload Course Material (Text/PDF)',
                    icon: Icons.upload_file,
                  ),
                  if (_sourceContent.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing),
                      child: Text(
                        'File selected. Content length: ${_sourceContent.length} characters.',
                        style: const TextStyle(color: AppColors.textColorSecondary),
                      ),
                    ),
                  const SizedBox(height: AppConstants.spacing * 2),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppConstants.spacing),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: AppColors.errorColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  _isLoading
                      ? const CircularProgressIndicator(color: AppColors.accentColor)
                      : CustomButton(
                          onPressed: _createCourse,
                          text: 'Generate Course',
                          icon: Icons.auto_awesome,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}