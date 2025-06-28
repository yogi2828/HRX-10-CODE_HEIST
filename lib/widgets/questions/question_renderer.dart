// lib/widgets/questions/question_renderer.dart
import 'package:flutter/material.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/widgets/questions/mcq_question_widget.dart';
import 'package:gamifier/widgets/questions/fill_in_blank_question_widget.dart';
import 'package:gamifier/widgets/questions/short_answer_question_widget.dart';
import 'package:gamifier/widgets/questions/scenario_question_widget.dart';

class QuestionRenderer extends StatelessWidget {
  final Question question;
  final Function(bool isCorrect, int xpAwarded, String? feedback) onSubmit;

  const QuestionRenderer({
    super.key,
    required this.question,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuestionType.mcq:
        return MCQQuestionWidget(question: question, onSubmit: onSubmit);
      case QuestionType.fillInBlank:
        return FillInBlankQuestionWidget(question: question, onSubmit: onSubmit);
      case QuestionType.shortAnswer:
        return ShortAnswerQuestionWidget(question: question, onSubmit: onSubmit);
      case QuestionType.scenario:
        return ScenarioQuestionWidget(question: question, onSubmit: onSubmit);
      default:
        return Text('Unsupported question type: ${question.type}');
    }
  }
}
