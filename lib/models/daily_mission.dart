// lib/models/daily_mission.dart
import 'package:flutter/foundation.dart';

@immutable
class DailyMission {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final bool isCompleted;

  const DailyMission({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    this.isCompleted = false,
  });

  factory DailyMission.fromMap(Map<String, dynamic> map) {
    return DailyMission(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      xpReward: map['xpReward'] as int,
      isCompleted: map['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'xpReward': xpReward,
      'isCompleted': isCompleted,
    };
  }

  DailyMission copyWith({
    String? id,
    String? title,
    String? description,
    int? xpReward,
    bool? isCompleted,
  }) {
    return DailyMission(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      xpReward: xpReward ?? this.xpReward,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'DailyMission(id: $id, title: $title, description: $description, xpReward: $xpReward, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyMission &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          xpReward == other.xpReward &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      xpReward.hashCode ^
      isCompleted.hashCode;
}
