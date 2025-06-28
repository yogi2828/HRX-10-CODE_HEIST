// lib/widgets/questions/scenario_question_widget.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/question.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/services/gemini_api_service.dart';
import 'dart:convert'; // For json.decode

class ScenarioQuestionWidget extends StatefulWidget {
  final Question question;
  final Function(bool isCorrect, int xpAwarded, String? feedback) onSubmit;

  const ScenarioQuestionWidget({
    super.key,
    required this.question,
    required this.onSubmit,
  });

  @override
  State<ScenarioQuestionWidget> createState() => _ScenarioQuestionWidgetState();
}

class _ScenarioQuestionWidgetState extends State<ScenarioQuestionWidget> {
  final TextEditingController _answerController = TextEditingController();
  bool _submitted = false;
  bool? _isCorrect;
  String? _feedback;
  bool _isCheckingAnswer = false;

  Future<void> _checkAnswer() async {
    if (_answerController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe your proposed solution.', style: TextStyle(color: AppColors.warningColor))),
      );
      return;
    }

    setState(() {
      _isCheckingAnswer = true;
    });

    final userAnswer = _answerController.text.trim();
    final expectedOutcome = widget.question.expectedOutcome ?? '';

    bool correct = false;
    String feedbackMessage = '';

    try {
      final geminiService = Provider.of<GeminiApiService>(context, listen: false);
      final prompt = "Evaluate the user's proposed solution for the given scenario. Focus on semantic correctness and completeness. Provide a boolean 'isCorrect' and a 'feedback' string. Scenario: '${widget.question.scenarioText}'. Expected Outcome/Solution Keywords: '$expectedOutcome'. User Proposed Solution: '$userAnswer'.\n\nExample JSON format: {\"isCorrect\": true, \"feedback\": \"Excellent analysis! Your solution aligns well with the expected outcome.\"}";
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
      correct = userAnswer.toLowerCase().contains(expectedOutcome.toLowerCase());
      feedbackMessage = correct
          ? 'Your solution seems plausible!'
          : 'Consider focusing on these key aspects: "$expectedOutcome".';
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
              'Scenario: ${widget.question.scenarioText ?? "No scenario provided."}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textColor),
            ),
            const SizedBox(height: AppConstants.padding),
            Text(
              widget.question.questionText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
            ),
            const SizedBox(height: AppConstants.padding),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                hintText: 'Describe your proposed solution or action...',
                filled: true,
                fillColor: AppColors.secondaryColor.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 5,
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
