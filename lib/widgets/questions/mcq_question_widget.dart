// lib/widgets/questions/mcq_question_widget.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/question.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/services/gemini_api_service.dart';
import 'dart:convert'; // For json.decode

class MCQQuestionWidget extends StatefulWidget {
  final Question question;
  final Function(bool isCorrect, int xpAwarded, String? feedback) onSubmit;

  const MCQQuestionWidget({
    super.key,
    required this.question,
    required this.onSubmit,
  });

  @override
  State<MCQQuestionWidget> createState() => _MCQQuestionWidgetState();
}

class _MCQQuestionWidgetState extends State<MCQQuestionWidget> {
  String? _selectedOption;
  bool _submitted = false;
  bool? _isCorrect;
  String? _feedback;
  bool _isCheckingAnswer = false;

  Future<void> _checkAnswer() async {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an option.', style: TextStyle(color: AppColors.warningColor))),
      );
      return;
    }

    setState(() {
      _isCheckingAnswer = true;
    });

    final selectedAnswer = _selectedOption!;
    final correctAnswer = widget.question.correctAnswer as String;

    bool correct = false;
    String feedbackMessage = '';

    if (widget.question.expectedAnswerKeywords != null && widget.question.expectedAnswerKeywords!.isNotEmpty) {
      try {
        final geminiService = Provider.of<GeminiApiService>(context, listen: false);
        final prompt = "Evaluate if the user's selected answer is correct given the question and correct answer. Provide a boolean 'isCorrect' and a 'feedback' string. Question: '${widget.question.questionText}'. User Answer: '$selectedAnswer'. Correct Answer: '$correctAnswer'. Expected Keywords/Concepts: '${widget.question.expectedAnswerKeywords}'.\n\nExample JSON format: {\"isCorrect\": true, \"feedback\": \"Excellent! That's the right choice.\"}";
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
        correct = selectedAnswer == correctAnswer;
        feedbackMessage = correct ? 'Correct!' : 'Incorrect. The correct answer was "$correctAnswer".';
      }
    } else {
      correct = selectedAnswer == correctAnswer;
      feedbackMessage = correct ? 'Correct!' : 'Incorrect. The correct answer was "$correctAnswer".';
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
            ...widget.question.options.map((option) {
              final isSelected = _selectedOption == option;
              Color? tileColor;
              if (_submitted) {
                if (option == widget.question.correctAnswer) {
                  tileColor = AppColors.successColor.withOpacity(0.3);
                } else if (isSelected && option != widget.question.correctAnswer) {
                  tileColor = AppColors.errorColor.withOpacity(0.3);
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
                child: AnimatedContainer(
                  duration: AppConstants.defaultAnimationDuration,
                  decoration: BoxDecoration(
                    color: tileColor ?? AppColors.secondaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    border: Border.all(
                      color: _submitted
                          ? (option == widget.question.correctAnswer
                              ? AppColors.successColor
                              : (isSelected ? AppColors.errorColor : AppColors.borderColor))
                          : (isSelected ? AppColors.accentColor : AppColors.borderColor),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: RadioListTile<String>(
                    title: Text(
                      option,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _submitted && option == widget.question.correctAnswer
                            ? AppColors.successColor
                            : (_submitted && isSelected && option != widget.question.correctAnswer
                                ? AppColors.errorColor
                                : AppColors.textColor),
                        fontWeight: _submitted && option == widget.question.correctAnswer ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    value: option,
                    groupValue: _selectedOption,
                    onChanged: _submitted
                        ? null
                        : (value) {
                            setState(() {
                              _selectedOption = value;
                            });
                          },
                    activeColor: AppColors.accentColor,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              );
            }).toList(),
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
}
