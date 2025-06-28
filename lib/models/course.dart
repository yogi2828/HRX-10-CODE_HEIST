// lib/models/course.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Course {
  final String id;
  final String creatorId;
  final String title;
  final String description;
  final String difficulty;
  final String gameGenre;
  final List<String> levelIds;
  final DateTime createdAt;

  const Course({
    required this.id,
    required this.creatorId,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.gameGenre,
    this.levelIds = const [],
    required this.createdAt,
  });

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] as String,
      creatorId: map['creatorId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      difficulty: map['difficulty'] as String,
      gameGenre: map['gameGenre'] as String,
      levelIds: List<String>.from(map['levelIds'] ?? []),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creatorId': creatorId,
      'title': title,
      'description': description,
      'difficulty': difficulty,
      'gameGenre': gameGenre,
      'levelIds': levelIds,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Course copyWith({
    String? id,
    String? creatorId,
    String? title,
    String? description,
    String? difficulty,
    String? gameGenre,
    List<String>? levelIds,
    DateTime? createdAt,
  }) {
    return Course(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      title: title ?? this.title,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      gameGenre: gameGenre ?? this.gameGenre,
      levelIds: levelIds ?? this.levelIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Course(id: $id, creatorId: $creatorId, title: $title, description: $description, difficulty: $difficulty, gameGenre: $gameGenre, levelIds: $levelIds, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          creatorId == other.creatorId &&
          title == other.title &&
          description == other.description &&
          difficulty == other.difficulty &&
          gameGenre == other.gameGenre &&
          listEquals(levelIds, other.levelIds) &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      creatorId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      difficulty.hashCode ^
      gameGenre.hashCode ^
      listEquals(levelIds, levelIds).hashCode ^
      createdAt.hashCode;
}
