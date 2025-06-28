// lib/widgets/lesson/question_widget.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/common/custom_text_field.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final ValueChanged<String> onSubmit;
  final bool isSubmitted;
  final String? lastUserAnswer;
  final bool? isLastAttemptCorrect;
  final int? xpAwarded;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.onSubmit,
    this.isSubmitted = false,
    this.lastUserAnswer,
    this.isLastAttemptCorrect,
    this.xpAwarded,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final TextEditingController _textAnswerController = TextEditingController();
  String? _selectedMcqOption;

  @override
  void initState() {
    super.initState();
    if (widget.isSubmitted) {
      if (widget.question.type == 'MCQ') {
        _selectedMcqOption = widget.lastUserAnswer;
      } else {
        _textAnswerController.text = widget.lastUserAnswer ?? '';
      }
    }
  }

  @override
  void dispose() {
    _textAnswerController.dispose();
    super.dispose();
  }

  Widget _buildQuestionInput() {
    switch (widget.question.type) {
      case 'MCQ':
        return Column(
          children: widget.question.options!.map((option) {
            return RadioListTile<String>(
              title: Text(
                option,
                style: TextStyle(
                  color: widget.isSubmitted && _selectedMcqOption == option
                      ? (widget.isLastAttemptCorrect! ? AppColors.successColor : AppColors.errorColor)
                      : AppColors.textColor,
                ),
              ),
              value: option,
              groupValue: _selectedMcqOption,
              onChanged: widget.isSubmitted
                  ? null
                  : (value) {
                      setState(() {
                        _selectedMcqOption = value;
                      });
                    },
              activeColor: AppColors.accentColor,
              tileColor: AppColors.cardColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                side: BorderSide(
                  color: widget.isSubmitted && _selectedMcqOption == option
                      ? (widget.isLastAttemptCorrect! ? AppColors.successColor : AppColors.errorColor)
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            );
          }).toList(),
        );
      case 'FillInBlank':
      case 'ShortAnswer':
        return CustomTextField(
          controller: _textAnswerController,
          labelText: 'Your Answer',
          icon: Icons.text_fields,
          keyboardType: TextInputType.text,
          maxLines: 2,
          readOnly: widget.isSubmitted,
        );
      case 'Scenario':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.padding),
              decoration: BoxDecoration(
                color: AppColors.cardColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Text(
                widget.question.scenarioText ?? 'No scenario provided.',
                style: const TextStyle(color: AppColors.textColor, fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: AppConstants.spacing * 2),
            CustomTextField(
              controller: _textAnswerController,
              labelText: 'What is the expected outcome?',
              icon: Icons.lightbulb_outline,
              keyboardType: TextInputType.text,
              maxLines: 3,
              readOnly: widget.isSubmitted,
            ),
          ],
        );
      default:
        return const Text('Unsupported Question Type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardColor.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        side: widget.isSubmitted
            ? BorderSide(
                color: widget.isLastAttemptCorrect! ? AppColors.successColor : AppColors.errorColor,
                width: 2,
              )
            : BorderSide.none,
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.questionText,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacing * 2),
            _buildQuestionInput(),
            const SizedBox(height: AppConstants.spacing * 2),
            if (!widget.isSubmitted)
              CustomButton(
                onPressed: () {
                  String answer = '';
                  if (widget.question.type == 'MCQ') {
                    answer = _selectedMcqOption ?? '';
                  } else {
                    answer = _textAnswerController.text;
                  }
                  widget.onSubmit(answer);
                },
                text: 'Submit Answer',
                icon: Icons.send,
              ),
            if (widget.isSubmitted)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.isLastAttemptCorrect! ? 'Correct!' : 'Incorrect.',
                        style: TextStyle(
                          color: widget.isLastAttemptCorrect! ? AppColors.successColor : AppColors.errorColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (widget.xpAwarded != null && widget.xpAwarded! > 0)
                        Text(
                          '+${widget.xpAwarded} XP',
                          style: const TextStyle(
                            color: AppColors.xpColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacing),
                  Text(
                    'Your Answer: "${widget.lastUserAnswer}"',
                    style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 14),
                  ),
                  if (!widget.isLastAttemptCorrect!)
                    Text(
                      'Correct Answer: ${widget.question.correctAnswer ?? widget.question.expectedAnswerKeywords ?? widget.question.expectedOutcome}',
                      style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 14),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}