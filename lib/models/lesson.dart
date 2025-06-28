// lib/models/lesson.dart
import 'package:flutter/foundation.dart';

@immutable
class Lesson {
  final String id;
  final String title;
  final String content;
  final List<String> questionIds;

  const Lesson({
    required this.id,
    required this.title,
    required this.content,
    this.questionIds = const [],
  });

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      questionIds: List<String>.from(map['questionIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'questionIds': questionIds,
    };
  }

  Lesson copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? questionIds,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      questionIds: questionIds ?? this.questionIds,
    );
  }

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title, content: $content, questionIds: $questionIds)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lesson &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content &&
          listEquals(questionIds, other.questionIds);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      listEquals(questionIds, questionIds).hashCode;
}
