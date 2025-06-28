import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/user_progress.dart';
import 'package:gamifier/models/user_profile.dart'; // Import UserProfile
import 'package:gamifier/services/firebase_service.dart'; // Import FirebaseService
import 'package:gamifier/services/gemini_api_service.dart';
import 'package:gamifier/widgets/common/custom_button.dart';

class PersonalizedFeedbackModal extends StatefulWidget {
  final bool isCorrect;
  final String userAnswer;
  final String questionText;
  final dynamic correctAnswer; // Can be String or List<String>
  final String lessonContent;
  final UserProgress userProgress; // Keep userProgress if it's still needed elsewhere

  const PersonalizedFeedbackModal({
    super.key,
    required this.isCorrect,
    required this.userAnswer,
    required this.questionText,
    required this.correctAnswer,
    required this.lessonContent,
    required this.userProgress,
  });

  @override
  State<PersonalizedFeedbackModal> createState() => _PersonalizedFeedbackModalState();
}

class _PersonalizedFeedbackModalState extends State<PersonalizedFeedbackModal> {
  bool _isLoadingFeedback = true;
  String _feedbackText = '';
  String _socraticFollowUp = '';
  String _adaptiveHints = '';
  String _encouragement = '';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _generateFeedback();
  }

  Future<void> _generateFeedback() async {
    setState(() {
      _isLoadingFeedback = true;
      _errorMessage = null;
    });

    try {
      final geminiService = Provider.of<GeminiApiService>(context, listen: false);
      final firebaseService = Provider.of<FirebaseService>(context, listen: false); // Get FirebaseService

      final currentUser = firebaseService.currentUser;
      if (currentUser == null) {
        throw Exception('User not logged in to generate feedback.');
      }

      // Fetch the latest UserProfile to pass to GeminiApiService
      final UserProfile? userProfile = await firebaseService.getUserProfile(currentUser.uid);
      if (userProfile == null) {
        throw Exception('User profile not found to generate feedback.');
      }

      final feedback = await geminiService.generateSocraticFeedback(
        userAnswer: widget.userAnswer,
        questionText: widget.questionText,
        correctAnswer: widget.correctAnswer.toString(),
        lessonContent: widget.lessonContent,
        userProfile: userProfile, // Pass the fetched UserProfile
      );

      setState(() {
        _feedbackText = feedback['feedbackText'] ?? 'No specific feedback provided.';
        _socraticFollowUp = feedback['socraticFollowUp'] ?? '';
        _adaptiveHints = feedback['adaptiveHints'] ?? '';
        _encouragement = feedback['encouragement'] ?? 'Keep up the great work!';
      });
    } catch (e) {
      debugPrint('Error generating feedback: $e');
      setState(() {
        _errorMessage = 'Failed to generate personalized feedback: ${e.toString()}';
        _feedbackText = widget.isCorrect
            ? 'That\'s correct! Well done!'
            : 'Not quite. The correct answer was: ${widget.correctAnswer}.';
        _encouragement = 'Keep trying!';
      });
    } finally {
      setState(() {
        _isLoadingFeedback = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.black54,
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent tap from closing modal
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.all(AppConstants.padding * 2),
                padding: const EdgeInsets.all(AppConstants.padding * 1.5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.cardColor.withOpacity(0.95),
                      AppColors.backgroundColor.withOpacity(0.95),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
                  border: Border.all(
                    color: widget.isCorrect ? AppColors.successColor : AppColors.errorColor,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isCorrect
                          ? AppColors.successColor.withOpacity(0.3)
                          : AppColors.errorColor.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          widget.isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
                          color: widget.isCorrect ? AppColors.successColor : AppColors.errorColor,
                          size: 70,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing * 2),
                      Center(
                        child: Text(
                          widget.isCorrect ? 'Correct Answer!' : 'Incorrect Answer.',
                          style: AppColors.neonTextStyle(
                            fontSize: 28,
                            color: widget.isCorrect ? AppColors.successColor : AppColors.errorColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing),
                      Text(
                        'Your Answer: "${widget.userAnswer}"',
                        style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                      if (!widget.isCorrect) ...[
                        const SizedBox(height: AppConstants.spacing),
                        Text(
                          'Correct Answer: "${widget.correctAnswer}"',
                          style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      const SizedBox(height: AppConstants.spacing * 2),
                      _isLoadingFeedback
                          ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
                          : _errorMessage != null
                              ? Center(
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(color: AppColors.errorColor, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'AI Tutor Feedback:',
                                      style: AppColors.neonTextStyle(fontSize: 18, color: AppColors.accentColor),
                                    ),
                                    const SizedBox(height: AppConstants.spacing),
                                    Text(
                                      _feedbackText,
                                      style: const TextStyle(color: AppColors.textColor, fontSize: 16),
                                    ),
                                    if (_socraticFollowUp.isNotEmpty) ...[
                                      const SizedBox(height: AppConstants.spacing),
                                      Text(
                                        'Think about it: $_socraticFollowUp',
                                        style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 15, fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                    if (_adaptiveHints.isNotEmpty) ...[
                                      const SizedBox(height: AppConstants.spacing),
                                      Text(
                                        'Hint: $_adaptiveHints',
                                        style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 15),
                                      ),
                                    ],
                                    const SizedBox(height: AppConstants.spacing * 2),
                                    Center(
                                      child: Text(
                                        _encouragement,
                                        style: const TextStyle(color: AppColors.xpColor, fontSize: 17, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                      const SizedBox(height: AppConstants.spacing * 3),
                      CustomButton(
                        onPressed: _isLoadingFeedback ? null : () => Navigator.of(context).pop(),
                        text: 'Continue',
                        icon: Icons.arrow_forward,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
