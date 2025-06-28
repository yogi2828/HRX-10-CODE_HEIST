// lib/models/question.dart
import 'package:flutter/foundation.dart';

enum QuestionType {
  mcq,
  fillInBlank,
  shortAnswer,
  scenario,
}

@immutable
class Question {
  final String id;
  final String questionText;
  final int xpReward;
  final QuestionType type;
  final List<String> options;
  final dynamic correctAnswer;
  final String? expectedAnswerKeywords;
  final String? scenarioText;
  final String? expectedOutcome;

  const Question({
    required this.id,
    required this.questionText,
    required this.xpReward,
    required this.type,
    this.options = const [],
    this.correctAnswer,
    this.expectedAnswerKeywords,
    this.scenarioText,
    this.expectedOutcome,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      questionText: map['questionText'] as String,
      xpReward: map['xpReward'] as int,
      type: QuestionType.values.firstWhere(
            (e) => e.toString().split('.').last == map['type'],
        orElse: () => QuestionType.shortAnswer,
      ),
      options: List<String>.from(map['options'] ?? []),
      correctAnswer: map['correctAnswer'],
      expectedAnswerKeywords: map['expectedAnswerKeywords'] as String?,
      scenarioText: map['scenarioText'] as String?,
      expectedOutcome: map['expectedOutcome'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'questionText': questionText,
      'xpReward': xpReward,
      'type': type.toString().split('.').last,
    };

    if (type == QuestionType.mcq) {
      map['options'] = options;
      map['correctAnswer'] = correctAnswer;
    } else if (type == QuestionType.fillInBlank) {
      map['correctAnswer'] = correctAnswer;
    } else if (type == QuestionType.shortAnswer) {
      map['expectedAnswerKeywords'] = expectedAnswerKeywords;
    } else if (type == QuestionType.scenario) {
      map['scenarioText'] = scenarioText;
      map['expectedOutcome'] = expectedOutcome;
    }
    return map;
  }

  Question copyWith({
    String? id,
    String? questionText,
    int? xpReward,
    QuestionType? type,
    List<String>? options,
    dynamic correctAnswer,
    String? expectedAnswerKeywords,
    String? scenarioText,
    String? expectedOutcome,
  }) {
    return Question(
      id: id ?? this.id,
      questionText: questionText ?? this.questionText,
      xpReward: xpReward ?? this.xpReward,
      type: type ?? this.type,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      expectedAnswerKeywords: expectedAnswerKeywords ?? this.expectedAnswerKeywords,
      scenarioText: scenarioText ?? this.scenarioText,
      expectedOutcome: expectedOutcome ?? this.expectedOutcome,
    );
  }

  @override
  String toString() {
    return 'Question(id: $id, questionText: $questionText, xpReward: $xpReward, type: $type, options: $options, correctAnswer: $correctAnswer, expectedAnswerKeywords: $expectedAnswerKeywords, scenarioText: $scenarioText, expectedOutcome: $expectedOutcome)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          questionText == other.questionText &&
          xpReward == other.xpReward &&
          type == other.type &&
          listEquals(options, other.options) &&
          correctAnswer == other.correctAnswer &&
          expectedAnswerKeywords == other.expectedAnswerKeywords &&
          scenarioText == other.scenarioText &&
          expectedOutcome == other.expectedOutcome;

  @override
  int get hashCode =>
      id.hashCode ^
      questionText.hashCode ^
      xpReward.hashCode ^
      type.hashCode ^
      listEquals(options, options).hashCode ^
      (correctAnswer?.hashCode ?? 0) ^
      (expectedAnswerKeywords?.hashCode ?? 0) ^
      (scenarioText?.hashCode ?? 0) ^
      (expectedOutcome?.hashCode ?? 0);
}
