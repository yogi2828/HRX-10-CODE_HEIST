// lib/models/lesson.dart
import 'package:gamifier/models/question.dart';

class Lesson {
  final String id;
  final String title;
  final String content;
  String levelId;
  final int order;
  final List<Question> questions;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.levelId,
    this.order = 0, // Default to 0 to prevent null -> int error
    this.questions = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'levelId': levelId,
      'order': order,
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      levelId: map['levelId'] as String? ?? '',
      order: map['order'] as int? ?? 0, // Safely cast and default to 0
      questions: (map['questions'] as List?)
              ?.map((q) => Question.fromMap(q as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Lesson copyWith({
    String? id,
    String? title,
    String? content,
    String? levelId,
    int? order,
    List<Question>? questions,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      levelId: levelId ?? this.levelId,
      order: order ?? this.order,
      questions: questions ?? this.questions,
    );
  }
}