// lib/models/level.dart
import 'package:flutter/material.dart';

class Level {
  final String id;
  final String title;
  final String description;
  String courseId;
  final String difficulty;
  final int order;
  final String? imageAssetPath;

  Level({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.difficulty,
    this.order = 0, // Default to 0 to prevent null -> int error
    this.imageAssetPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'courseId': courseId,
      'difficulty': difficulty,
      'order': order,
      'imageAssetPath': imageAssetPath,
    };
  }

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      courseId: map['courseId'] as String? ?? '',
      difficulty: map['difficulty'] as String,
      order: map['order'] as int? ?? 0, // Safely cast and default to 0
      imageAssetPath: map['imageAssetPath'] as String?,
    );
  }

  Level copyWith({
    String? id,
    String? title,
    String? description,
    String? courseId,
    String? difficulty,
    int? order,
    String? imageAssetPath,
  }) {
    return Level(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      courseId: courseId ?? this.courseId,
      difficulty: difficulty ?? this.difficulty,
      order: order ?? this.order,
      imageAssetPath: imageAssetPath ?? this.imageAssetPath,
    );
  }
}
