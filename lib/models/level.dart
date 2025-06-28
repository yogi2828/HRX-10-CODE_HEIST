// lib/models/level.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gamifier/models/lesson.dart';

@immutable
class Level {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final String difficulty;
  final int order;
  final List<String> lessonIds;
  final String? imageAssetPath;

  const Level({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.order,
    this.lessonIds = const [],
    this.imageAssetPath,
  });

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      id: map['id'] as String,
      courseId: map['courseId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      difficulty: map['difficulty'] as String,
      order: map['order'] as int,
      lessonIds: List<String>.from(map['lessonIds'] ?? []),
      imageAssetPath: map['imageAssetPath'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'difficulty': difficulty,
      'order': order,
      'lessonIds': lessonIds,
      'imageAssetPath': imageAssetPath,
    };
  }

  Level copyWith({
    String? id,
    String? courseId,
    String? title,
    String? description,
    String? difficulty,
    int? order,
    List<String>? lessonIds,
    String? imageAssetPath,
  }) {
    return Level(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      order: order ?? this.order,
      lessonIds: lessonIds ?? this.lessonIds,
      imageAssetPath: imageAssetPath ?? this.imageAssetPath,
    );
  }

  @override
  String toString() {
    return 'Level(id: $id, courseId: $courseId, title: $title, description: $description, difficulty: $difficulty, order: $order, lessonIds: $lessonIds, imageAssetPath: $imageAssetPath)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Level &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          courseId == other.courseId &&
          title == other.title &&
          description == other.description &&
          difficulty == other.difficulty &&
          order == other.order &&
          listEquals(lessonIds, other.lessonIds) &&
          imageAssetPath == other.imageAssetPath;

  @override
  int get hashCode =>
      id.hashCode ^
      courseId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      difficulty.hashCode ^
      order.hashCode ^
      listEquals(lessonIds, lessonIds).hashCode ^
      imageAssetPath.hashCode;
}
