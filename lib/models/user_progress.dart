// lib/models/user_progress.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class LessonProgress {
  final String lessonId;
  final List<String> completedQuestions;
  final Map<String, int> attempts;
  bool isCompleted;
  double performanceScore; // New: Stores a score for adaptive learning

  LessonProgress({
    required this.lessonId,
    this.completedQuestions = const [],
    Map<String, int>? attempts,
    this.isCompleted = false,
    this.performanceScore = 0.0, // Initialize performance score
  }) : attempts = attempts ?? {};

  factory LessonProgress.fromMap(Map<String, dynamic> map) {
    return LessonProgress(
      lessonId: map['lessonId'] as String,
      completedQuestions: List<String>.from(map['completedQuestions'] ?? []),
      attempts: Map<String, int>.from(
          (map['attempts'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, value as int)) ?? {}),
      isCompleted: map['isCompleted'] as bool? ?? false,
      performanceScore: (map['performanceScore'] as num?)?.toDouble() ?? 0.0, // New
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'completedQuestions': completedQuestions,
      'attempts': attempts,
      'isCompleted': isCompleted,
      'performanceScore': performanceScore, // New
    };
  }

  LessonProgress copyWith({
    String? lessonId,
    List<String>? completedQuestions,
    Map<String, int>? attempts,
    bool? isCompleted,
    double? performanceScore, // New
  }) {
    return LessonProgress(
      lessonId: lessonId ?? this.lessonId,
      completedQuestions: completedQuestions ?? this.completedQuestions,
      attempts: attempts ?? this.attempts,
      isCompleted: isCompleted ?? this.isCompleted,
      performanceScore: performanceScore ?? this.performanceScore, // New
    );
  }

  @override
  String toString() {
    return 'LessonProgress(lessonId: $lessonId, completedQuestions: $completedQuestions, attempts: $attempts, isCompleted: $isCompleted, performanceScore: $performanceScore)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonProgress &&
          runtimeType == other.runtimeType &&
          lessonId == other.lessonId &&
          listEquals(completedQuestions, other.completedQuestions) &&
          mapEquals(attempts, other.attempts) &&
          isCompleted == other.isCompleted &&
          performanceScore == other.performanceScore; // New

  @override
  int get hashCode =>
      lessonId.hashCode ^
      listEquals(completedQuestions, completedQuestions).hashCode ^
      mapEquals(attempts, attempts).hashCode ^
      isCompleted.hashCode ^
      performanceScore.hashCode; // New
}

@immutable
class UserProgress {
  final String id;
  final String userId;
  final String courseId;
  String? currentLevelId;
  String? currentLessonId;
  final List<String> levelsCompleted;
  final Map<String, LessonProgress> lessonsProgress;
  final int totalXpEarned;
  final List<String> dailyMissionsCompleted; // New: Track daily missions

  UserProgress({
    required this.id,
    required this.userId,
    required this.courseId,
    this.currentLevelId,
    this.currentLessonId,
    this.levelsCompleted = const [],
    Map<String, LessonProgress>? lessonsProgress,
    this.totalXpEarned = 0,
    this.dailyMissionsCompleted = const [], // New
  }) : lessonsProgress = lessonsProgress ?? const {};

  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      id: map['id'] as String,
      userId: map['userId'] as String,
      courseId: map['courseId'] as String,
      currentLevelId: map['currentLevelId'] as String?,
      currentLessonId: map['currentLessonId'] as String?,
      levelsCompleted: List<String>.from(map['levelsCompleted'] ?? []),
      lessonsProgress: (map['lessonsProgress'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, LessonProgress.fromMap(value as Map<String, dynamic>))) ??
          {},
      totalXpEarned: map['totalXpEarned'] as int? ?? 0,
      dailyMissionsCompleted: List<String>.from(map['dailyMissionsCompleted'] ?? []), // New
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'currentLevelId': currentLevelId,
      'currentLessonId': currentLessonId,
      'levelsCompleted': levelsCompleted,
      'lessonsProgress': lessonsProgress.map((key, value) => MapEntry(key, value.toMap())),
      'totalXpEarned': totalXpEarned,
      'dailyMissionsCompleted': dailyMissionsCompleted, // New
    };
  }

  UserProgress copyWith({
    String? id,
    String? userId,
    String? courseId,
    String? currentLevelId,
    String? currentLessonId,
    List<String>? levelsCompleted,
    Map<String, LessonProgress>? lessonsProgress,
    int? totalXpEarned,
    List<String>? dailyMissionsCompleted, // New
  }) {
    return UserProgress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      currentLevelId: currentLevelId ?? this.currentLevelId,
      currentLessonId: currentLessonId ?? this.currentLessonId,
      levelsCompleted: levelsCompleted ?? this.levelsCompleted,
      lessonsProgress: lessonsProgress ?? this.lessonsProgress,
      totalXpEarned: totalXpEarned ?? this.totalXpEarned,
      dailyMissionsCompleted: dailyMissionsCompleted ?? this.dailyMissionsCompleted, // New
    );
  }

  @override
  String toString() {
    return 'UserProgress(id: $id, userId: $userId, courseId: $courseId, currentLevelId: $currentLevelId, currentLessonId: $currentLessonId, levelsCompleted: $levelsCompleted, lessonsProgress: $lessonsProgress, totalXpEarned: $totalXpEarned, dailyMissionsCompleted: $dailyMissionsCompleted)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProgress &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          courseId == other.courseId &&
          currentLevelId == other.currentLevelId &&
          currentLessonId == other.currentLessonId &&
          listEquals(levelsCompleted, other.levelsCompleted) &&
          mapEquals(lessonsProgress, other.lessonsProgress) &&
          totalXpEarned == other.totalXpEarned &&
          listEquals(dailyMissionsCompleted, other.dailyMissionsCompleted); // New

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      courseId.hashCode ^
      (currentLevelId?.hashCode ?? 0) ^
      (currentLessonId?.hashCode ?? 0) ^
      listEquals(levelsCompleted, levelsCompleted).hashCode ^
      mapEquals(lessonsProgress, lessonsProgress).hashCode ^
      totalXpEarned.hashCode ^
      listEquals(dailyMissionsCompleted, dailyMissionsCompleted).hashCode; // New
}
