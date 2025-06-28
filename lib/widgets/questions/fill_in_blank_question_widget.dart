// lib/widgets/questions/fill_in_blank_question_widget.dart
import 'package:flutter/material.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/widgets/lesson/question_widget.dart';

class FillInBlankQuestionWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<String> onSubmit;
  final bool isSubmitted;
  final String? lastUserAnswer;
  final bool? isLastAttemptCorrect;
  final int? xpAwarded;

  const FillInBlankQuestionWidget({
    super.key,
    required this.question,
    required this.onSubmit,
    this.isSubmitted = false,
    this.lastUserAnswer,
    this.isLastAttemptCorrect,
    this.xpAwarded,
  });

  @override
  Widget build(BuildContext context) {
    return QuestionWidget(
      question: question,
      onSubmit: onSubmit,
      isSubmitted: isSubmitted,
      lastUserAnswer: lastUserAnswer,
      isLastAttemptCorrect: isLastAttemptCorrect,
      xpAwarded: xpAwarded,
    );
  }
}