// lib/widgets/questions/short_answer_question_widget.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/question.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/services/gemini_api_service.dart';
import 'dart:convert'; // For json.decode

class ShortAnswerQuestionWidget extends StatefulWidget {
  final Question question;
  final Function(bool isCorrect, int xpAwarded, String? feedback) onSubmit;

  const ShortAnswerQuestionWidget({
    super.key,
    required this.question,
    required this.onSubmit,
  });

  @override
  State<ShortAnswerQuestionWidget> createState() => _ShortAnswerQuestionWidgetState();
}

class _ShortAnswerQuestionWidgetState extends State<ShortAnswerQuestionWidget> {
  final TextEditingController _answerController = TextEditingController();
  bool _submitted = false;
  bool? _isCorrect;
  String? _feedback;
  bool _isCheckingAnswer = false;

  Future<void> _checkAnswer() async {
    if (_answerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your answer.', style: TextStyle(color: AppColors.warningColor))),
      );
      return;
    }

    setState(() {
      _isCheckingAnswer = true;
    });

    final userAnswer = _answerController.text.trim();
    final expectedKeywords = widget.question.expectedAnswerKeywords ?? '';

    bool correct = false;
    String feedbackMessage = '';

    try {
      final geminiService = Provider.of<GeminiApiService>(context, listen: false);
      final prompt = "Evaluate if the user's short answer semantically matches the expected keywords. Provide a boolean 'isCorrect' and a 'feedback' string. User Answer: '$userAnswer'. Expected Keywords/Concepts: '$expectedKeywords'.\n\nExample JSON format: {\"isCorrect\": true, \"feedback\": \"Excellent! You captured the key points.\"}";
      final schema = {
        "type": "OBJECT",
        "properties": {
          "isCorrect": {"type": "BOOLEAN"},
          "feedback": {"type": "STRING"}
        },
        "propertyOrdering": ["isCorrect", "feedback"]
      };

      final jsonString = await geminiService.generateStructuredText(prompt, schema);
      final result = json.decode(jsonString);
      correct = result['isCorrect'] as bool;
      feedbackMessage = result['feedback'] as String;
    } catch (e) {
      print('AI evaluation error: $e');
      // Fallback to basic keyword check if AI fails
      correct = expectedKeywords.split(',').any((keyword) =>
          userAnswer.toLowerCase().contains(keyword.trim().toLowerCase()));
      feedbackMessage = correct
          ? 'Your answer is generally correct!'
          : 'Consider these keywords: "$expectedKeywords".';
    }

    setState(() {
      _isCorrect = correct;
      _submitted = true;
      _feedback = feedbackMessage;
      _isCheckingAnswer = false;
    });

    widget.onSubmit(correct, correct ? widget.question.xpReward : 0, _feedback);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardColor,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.questionText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
            ),
            const SizedBox(height: AppConstants.padding),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                hintText: 'Type your answer here...',
                filled: true,
                fillColor: AppColors.secondaryColor.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 3,
              enabled: !_submitted,
            ),
            const SizedBox(height: AppConstants.padding),
            _isCheckingAnswer
                ? const Center(child: CircularProgressIndicator(color: AppColors.accentColor))
                : Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _submitted ? null : _checkAnswer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentColor,
                        padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding * 1.5, vertical: AppConstants.padding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        ),
                      ),
                      child: Text(_submitted ? 'Answered' : 'Submit', style: const TextStyle(color: AppColors.textColor)),
                    ),
                  ),
            if (_submitted) ...[
              const SizedBox(height: AppConstants.padding),
              Container(
                padding: const EdgeInsets.all(AppConstants.padding),
                decoration: BoxDecoration(
                  color: _isCorrect! ? AppColors.successColor.withOpacity(0.2) : AppColors.errorColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  border: Border.all(color: _isCorrect! ? AppColors.successColor : AppColors.errorColor),
                ),
                child: Text(
                  _feedback ?? (_isCorrect! ? 'Correct!' : 'Incorrect.'),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _isCorrect! ? AppColors.successColor : AppColors.errorColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }
}
