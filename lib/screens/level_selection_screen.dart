// gamifier/lib/screens/level_selection_screen.dart (Adjusted for TopNavBar and layout)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/course.dart';
import 'package:gamifier/models/user_profile.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/services/gemini_api_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/common/custom_text_field.dart';
import 'package:gamifier/widgets/course/course_card.dart';
import 'package:gamifier/widgets/navigation/top_nav_bar.dart'; // Import TopNavBar

class LevelSelectionScreen extends StatefulWidget {
  const LevelSelectionScreen({super.key});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  final TextEditingController _courseTopicController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _difficultyController = TextEditingController();
  final TextEditingController _educationLevelController = TextEditingController();

  UserProfile? _userProfile;
  List<Course> _allCourses = [];
  bool _isLoading = false;
  String? _errorMessage;

  late FirebaseService _firebaseService;
  late GeminiApiService _geminiApiService;

  @override
  void initState() {
    super.initState();
    _firebaseService = Provider.of<FirebaseService>(context, listen: false);
    _geminiApiService = Provider.of<GeminiApiService>(context, listen: false);
    _loadUserProfileAndCourses();
  }

  @override
  void dispose() {
    _courseTopicController.dispose();
    _languageController.dispose();
    _difficultyController.dispose();
    _educationLevelController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfileAndCourses() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userProfile = await _firebaseService.streamUserProfile().first;
      final courses = await _firebaseService.getAllCourses();
      if (mounted) {
        setState(() {
          _userProfile = userProfile;
          _allCourses = courses;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load data: $e';
        });
      }
      debugPrint('Error loading user profile or courses: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _generateCourse() async {
    if (_courseTopicController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a course topic.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final courseTopic = _courseTopicController.text;
      final language = _languageController.text.isNotEmpty ? _languageController.text : 'English';
      final difficulty = _difficultyController.text.isNotEmpty ? _difficultyController.text : 'Beginner';
      final educationLevel = _educationLevelController.text.isNotEmpty ? _educationLevelController.text : 'Not Specified';

      final coursePrompt =
          "Generate a learning course outline on '$courseTopic' in '$language' language, suitable for '$difficulty' level, targeting '$educationLevel' students. The course should have ${AppConstants.initialLevelsCount} levels, each with 2-3 lessons. Provide a course title, a brief description, and for each level, a title and 2-3 lesson titles with brief descriptions. Ensure the content is suitable for a gamified learning app. Format the response as a JSON object with 'title', 'description', and 'levels' (an array of level objects). Each level object should have 'title' and 'lessons' (an array of lesson objects). Each lesson object should have 'title' and 'description'.";

      final generatedCourseData = await _geminiApiService.generateContent(coursePrompt);

      if (generatedCourseData != null) {
        final newCourse = Course.fromJson(generatedCourseData)..userId = _userProfile?.id;
        final courseId = await _firebaseService.addCourse(newCourse);
        newCourse.id = courseId; // Set the ID from Firestore

        if (mounted) {
          setState(() {
            _allCourses.add(newCourse);
          });
          // Navigate to the newly created course's levels
          Navigator.of(context).pushNamed(
            AppRouter.levelSelectionRoute,
            arguments: newCourse.id,
          );
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'Failed to generate course. Please try again.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error generating course: $e';
        });
      }
      debugPrint('Error generating course: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopNavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppConstants.topNavBarHeight + AppConstants.padding), // Space below TopNavBar
              // Course Generation Section
              _buildCourseGenerationSection(),
              const SizedBox(height: AppConstants.padding * 2),

              // My Courses Section
              Text(
                'My Courses',
                style: AppColors.neonTextStyle(fontSize: 28, color: AppColors.accentColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacing * 2),
              _buildMyCoursesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseGenerationSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.padding),
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColorDark.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Generate a New Course with AI',
            style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.secondaryColor),
          ),
          const SizedBox(height: AppConstants.padding),
          CustomTextField(
            controller: _courseTopicController,
            labelText: 'Course Topic (e.g., Quantum Physics, Web Dev)',
            hintText: 'Enter your desired course topic',
            icon: Icons.topic_rounded,
          ),
          const SizedBox(height: AppConstants.spacing),
          CustomTextField(
            controller: _languageController,
            labelText: 'Language',
            hintText: 'e.g., English, Hindi, Spanish',
            icon: Icons.language_rounded,
            readOnly: true,
            onTap: () => _showSelectionDialog(
              context,
              'Select Language',
              AppConstants.supportedLanguages,
              _languageController,
            ),
          ),
          const SizedBox(height: AppConstants.spacing),
          CustomTextField(
            controller: _difficultyController,
            labelText: 'Difficulty Level',
            hintText: 'e.g., Beginner, Intermediate, Expert',
            icon: Icons.bar_chart_rounded,
            readOnly: true,
            onTap: () => _showSelectionDialog(
              context,
              'Select Difficulty',
              AppConstants.difficultyLevels,
              _difficultyController,
            ),
          ),
          const SizedBox(height: AppConstants.spacing),
          CustomTextField(
            controller: _educationLevelController,
            labelText: 'Education Level',
            hintText: 'e.g., High School, Bachelor\'s Degree',
            icon: Icons.school_rounded,
            readOnly: true,
            onTap: () => _showSelectionDialog(
              context,
              'Select Education Level',
              AppConstants.educationLevels,
              _educationLevelController,
            ),
          ),
          const SizedBox(height: AppConstants.padding),
          _errorMessage != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.spacing),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: AppColors.errorColor),
                    textAlign: TextAlign.center,
                  ),
                )
              : const SizedBox.shrink(),
          Center(
            child: CustomButton(
              text: 'Generate Course',
              icon: Icons.auto_awesome_rounded,
              onPressed: _isLoading ? () {} : _generateCourse,
              isLoading: _isLoading,
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyCoursesList() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor)),
      );
    }
    if (_allCourses.isEmpty) {
      return Center(
        child: Text(
          'No courses created yet. Generate one above!',
          style: TextStyle(color: AppColors.textColorSecondary),
        ),
      );
    }
    return Align(
      alignment: Alignment.center,
      child: Wrap(
        spacing: AppConstants.padding,
        runSpacing: AppConstants.padding,
        alignment: WrapAlignment.center,
        children: _allCourses.map((course) {
          return CourseCard(course: course);
        }).toList(),
      ),
    );
  }

  void _showSelectionDialog(BuildContext context, String title, List<String> options, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: AppColors.cardColor.withOpacity(0.95),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(AppConstants.padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppColors.neonTextStyle(fontSize: 22, color: AppColors.accentColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.padding),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options[index];
                      return ListTile(
                        title: Text(
                          option,
                          style: TextStyle(color: AppColors.textColor),
                        ),
                        onTap: () {
                          controller.text = option;
                          Navigator.of(dialogContext).pop();
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppConstants.spacing),
                CustomButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  isSecondary: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}