// lib/models/course.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Course {
  final String id;
  final String title;
  final String description;
  final String? gameGenre; // Made nullable as it's being replaced by language
  final String language; // New field for course language
  final String difficulty;
  final String creatorId;
  final DateTime createdAt;
  final List<String> levelIds;
  final String? educationLevel;
  final String? specialty;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    this.gameGenre, // Now optional
    required this.language, // Now required
    required this.difficulty,
    required this.creatorId,
    required this.createdAt,
    this.levelIds = const [],
    this.educationLevel,
    this.specialty,
  });

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      gameGenre: map['gameGenre'] as String?, // Read as nullable
      language: map['language'] as String? ?? 'English', // New field, default to English
      difficulty: map['difficulty'] as String,
      creatorId: map['creatorId'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      levelIds: List<String>.from(map['levelIds'] ?? []),
      educationLevel: map['educationLevel'] as String?,
      specialty: map['specialty'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'gameGenre': gameGenre,
      'language': language, // Include in map
      'difficulty': difficulty,
      'creatorId': creatorId,
      'createdAt': Timestamp.fromDate(createdAt),
      'levelIds': levelIds,
      'educationLevel': educationLevel,
      'specialty': specialty,
    };
  }

  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? gameGenre,
    String? language, // Update copyWith
    String? difficulty,
    String? creatorId,
    DateTime? createdAt,
    List<String>? levelIds,
    String? educationLevel,
    String? specialty,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      gameGenre: gameGenre ?? this.gameGenre,
      language: language ?? this.language, // Copy language
      difficulty: difficulty ?? this.difficulty,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      levelIds: levelIds ?? this.levelIds,
      educationLevel: educationLevel ?? this.educationLevel,
      specialty: specialty ?? this.specialty,
    );
  }

  @override
  String toString() {
    return 'Course(id: $id, title: $title, description: $description, gameGenre: $gameGenre, language: $language, difficulty: $difficulty, creatorId: $creatorId, createdAt: $createdAt, levelIds: $levelIds, educationLevel: $educationLevel, specialty: $specialty)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          gameGenre == other.gameGenre &&
          language == other.language && // Compare language
          difficulty == other.difficulty &&
          creatorId == other.creatorId &&
          createdAt == other.createdAt &&
          listEquals(levelIds, other.levelIds) &&
          educationLevel == other.educationLevel &&
          specialty == other.specialty;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      (gameGenre?.hashCode ?? 0) ^ // Update hash code
      language.hashCode ^ // Add language to hash code
      difficulty.hashCode ^
      creatorId.hashCode ^
      createdAt.hashCode ^
      listEquals(levelIds, levelIds).hashCode ^
      (educationLevel?.hashCode ?? 0) ^
      (specialty?.hashCode ?? 0);
}