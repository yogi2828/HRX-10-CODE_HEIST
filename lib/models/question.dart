
// lib/models/question.dart
class Question {
  final String id;
  final String questionText;
  final String type;
  final int xpReward; // Ensure this is always an int

  final List<String>? options;
  final String? correctAnswer;
  final String? expectedAnswerKeywords;
  final String? scenarioText;
  final String? expectedOutcome;

  Question({
    required this.id,
    required this.questionText,
    required this.type,
    this.xpReward = 0, // Default to 0 if not provided, to prevent null -> int cast issues
    this.options,
    this.correctAnswer,
    this.expectedAnswerKeywords,
    this.scenarioText,
    this.expectedOutcome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionText': questionText,
      'type': type,
      'xpReward': xpReward,
      if (options != null) 'options': options,
      if (correctAnswer != null) 'correctAnswer': correctAnswer,
      if (expectedAnswerKeywords != null) 'expectedAnswerKeywords': expectedAnswerKeywords,
      if (scenarioText != null) 'scenarioText': scenarioText,
      if (expectedOutcome != null) 'expectedOutcome': expectedOutcome,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      questionText: map['questionText'] as String,
      type: map['type'] as String,
      xpReward: map['xpReward'] as int? ?? 0, // Safely cast and default to 0
      options: (map['options'] as List?)?.map((e) => e as String).toList(),
      correctAnswer: map['correctAnswer'] as String?,
      expectedAnswerKeywords: map['expectedAnswerKeywords'] as String?,
      scenarioText: map['scenarioText'] as String?,
      expectedOutcome: map['expectedOutcome'] as String?,
    );
  }

  Question copyWith({
    String? id,
    String? questionText,
    String? type,
    int? xpReward,
    List<String>? options,
    String? correctAnswer,
    String? expectedAnswerKeywords,
    String? scenarioText,
    String? expectedOutcome,
}) {
    return Question(
      id: id ?? this.id,
      questionText: questionText ?? this.questionText,
      type: type ?? this.type,
      xpReward: xpReward ?? this.xpReward,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      expectedAnswerKeywords: expectedAnswerKeywords ?? this.expectedAnswerKeywords,
      scenarioText: scenarioText ?? this.scenarioText,
      expectedOutcome: expectedOutcome ?? this.expectedOutcome,
    );
  }
}