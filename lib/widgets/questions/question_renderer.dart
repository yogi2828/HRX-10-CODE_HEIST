// lib/widgets/questions/question_renderer.dart
import 'package:flutter/material.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/widgets/questions/mcq_question_widget.dart';
import 'package:gamifier/widgets/questions/fill_in_blank_question_widget.dart';
import 'package:gamifier/widgets/questions/short_answer_question_widget.dart';
import 'package:gamifier/widgets/questions/scenario_question_widget.dart';

class QuestionRenderer extends StatelessWidget {
  final Question question;
  final ValueChanged<String> onSubmit;
  final bool isSubmitted;
  final String? lastUserAnswer;
  final bool? isLastAttemptCorrect;
  final int? xpAwarded;

  const QuestionRenderer({
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
    switch (question.type) {
      case 'MCQ':
        return McqQuestionWidget(
          question: question,
          onSubmit: onSubmit,
          isSubmitted: isSubmitted,
          lastUserAnswer: lastUserAnswer,
          isLastAttemptCorrect: isLastAttemptCorrect,
          xpAwarded: xpAwarded,
        );
      case 'FillInBlank':
        return FillInBlankQuestionWidget(
          question: question,
          onSubmit: onSubmit,
          isSubmitted: isSubmitted,
          lastUserAnswer: lastUserAnswer,
          isLastAttemptCorrect: isLastAttemptCorrect,
          xpAwarded: xpAwarded,
        );
      case 'ShortAnswer':
        return ShortAnswerQuestionWidget(
          question: question,
          onSubmit: onSubmit,
          isSubmitted: isSubmitted,
          lastUserAnswer: lastUserAnswer,
          isLastAttemptCorrect: isLastAttemptCorrect,
          xpAwarded: xpAwarded,
        );
      case 'Scenario':
        return ScenarioQuestionWidget(
          question: question,
          onSubmit: onSubmit,
          isSubmitted: isSubmitted,
          lastUserAnswer: lastUserAnswer,
          isLastAttemptCorrect: isLastAttemptCorrect,
          xpAwarded: xpAwarded,
        );
      default:
        return Center(child: Text('Unknown question type: ${question.type}'));
    }
  }
}