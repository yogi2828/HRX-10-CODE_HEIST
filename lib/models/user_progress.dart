// lib/models/user_progress.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserProgress {
  final String id;
  final String userId;
  final String courseId;
  final String? currentLevelId;
  final String? currentLessonId;
  final Map<String, LevelProgress> levelsProgress;
  final Map<String, LessonProgress> lessonsProgress;

  const UserProgress({
    required this.id,
    required this.userId,
    required this.courseId,
    this.currentLevelId,
    this.currentLessonId,
    this.levelsProgress = const {},
    this.lessonsProgress = const {},
  });

  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      id: map['id'] as String,
      userId: map['userId'] as String,
      courseId: map['courseId'] as String,
      currentLevelId: map['currentLevelId'] as String?,
      currentLessonId: map['currentLessonId'] as String?,
      levelsProgress: (map['levelsProgress'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, LevelProgress.fromMap(value as Map<String, dynamic>))) ??
          {},
      lessonsProgress: (map['lessonsProgress'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, LessonProgress.fromMap(value as Map<String, dynamic>))) ??
          {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'currentLevelId': currentLevelId,
      'currentLessonId': currentLessonId,
      'levelsProgress': levelsProgress.map((key, value) => MapEntry(key, value.toMap())),
      'lessonsProgress': lessonsProgress.map((key, value) => MapEntry(key, value.toMap())),
    };
  }

  UserProgress copyWith({
    String? id,
    String? userId,
    String? courseId,
    String? currentLevelId,
    String? currentLessonId,
    Map<String, LevelProgress>? levelsProgress,
    Map<String, LessonProgress>? lessonsProgress,
  }) {
    return UserProgress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      currentLevelId: currentLevelId ?? this.currentLevelId,
      currentLessonId: currentLessonId ?? this.currentLessonId,
      levelsProgress: levelsProgress ?? this.levelsProgress,
      lessonsProgress: lessonsProgress ?? this.lessonsProgress,
    );
  }

  @override
  String toString() {
    return 'UserProgress(id: $id, userId: $userId, courseId: $courseId, currentLevelId: $currentLevelId, currentLessonId: $currentLessonId, levelsProgress: $levelsProgress, lessonsProgress: $lessonsProgress)';
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
          mapEquals(levelsProgress, other.levelsProgress) &&
          mapEquals(lessonsProgress, other.lessonsProgress);

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      courseId.hashCode ^
      currentLevelId.hashCode ^
      currentLessonId.hashCode ^
      mapEquals(levelsProgress, levelsProgress).hashCode ^
      mapEquals(lessonsProgress, lessonsProgress).hashCode;
}

@immutable
class LevelProgress {
  final bool isCompleted;
  final int xpEarned;
  final int score;
  final DateTime? completedAt;

  const LevelProgress({
    this.isCompleted = false,
    this.xpEarned = 0,
    this.score = 0,
    this.completedAt,
  });

  factory LevelProgress.fromMap(Map<String, dynamic> map) {
    return LevelProgress(
      isCompleted: map['isCompleted'] as bool,
      xpEarned: map['xpEarned'] as int,
      score: map['score'] as int,
      completedAt: map['completedAt'] != null ? (map['completedAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isCompleted': isCompleted,
      'xpEarned': xpEarned,
      'score': score,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
    };
  }

  LevelProgress copyWith({
    bool? isCompleted,
    int? xpEarned,
    int? score,
    DateTime? completedAt,
  }) {
    return LevelProgress(
      isCompleted: isCompleted ?? this.isCompleted,
      xpEarned: xpEarned ?? this.xpEarned,
      score: score ?? this.score,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  String toString() {
    return 'LevelProgress(isCompleted: $isCompleted, xpEarned: $xpEarned, score: $score, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelProgress &&
          runtimeType == other.runtimeType &&
          isCompleted == other.isCompleted &&
          xpEarned == other.xpEarned &&
          score == other.score &&
          completedAt == other.completedAt;

  @override
  int get hashCode =>
      isCompleted.hashCode ^ xpEarned.hashCode ^ score.hashCode ^ completedAt.hashCode;
}

@immutable
class LessonProgress {
  final bool isCompleted;
  final int xpEarned;
  final Map<String, QuestionAttempt> questionAttempts;
  final DateTime? completedAt;

  const LessonProgress({
    this.isCompleted = false,
    this.xpEarned = 0,
    this.questionAttempts = const {},
    this.completedAt,
  });

  factory LessonProgress.fromMap(Map<String, dynamic> map) {
    return LessonProgress(
      isCompleted: map['isCompleted'] as bool,
      xpEarned: map['xpEarned'] as int,
      questionAttempts: (map['questionAttempts'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, QuestionAttempt.fromMap(value as Map<String, dynamic>))) ??
          {},
      completedAt: map['completedAt'] != null ? (map['completedAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isCompleted': isCompleted,
      'xpEarned': xpEarned,
      'questionAttempts': questionAttempts.map((key, value) => MapEntry(key, value.toMap())),
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
    };
  }

  LessonProgress copyWith({
    bool? isCompleted,
    int? xpEarned,
    Map<String, QuestionAttempt>? questionAttempts,
    DateTime? completedAt,
  }) {
    return LessonProgress(
      isCompleted: isCompleted ?? this.isCompleted,
      xpEarned: xpEarned ?? this.xpEarned,
      questionAttempts: questionAttempts ?? this.questionAttempts,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  String toString() {
    return 'LessonProgress(isCompleted: $isCompleted, xpEarned: $xpEarned, questionAttempts: $questionAttempts, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonProgress &&
          runtimeType == other.runtimeType &&
          isCompleted == other.isCompleted &&
          xpEarned == other.xpEarned &&
          mapEquals(questionAttempts, other.questionAttempts) &&
          completedAt == other.completedAt;

  @override
  int get hashCode =>
      isCompleted.hashCode ^ xpEarned.hashCode ^ mapEquals(questionAttempts, questionAttempts).hashCode ^ completedAt.hashCode;
}

@immutable
class QuestionAttempt {
  final String userAnswer;
  final bool isCorrect;
  final DateTime attemptedAt;
  final int xpAwarded;

  const QuestionAttempt({
    required this.userAnswer,
    required this.isCorrect,
    required this.attemptedAt,
    this.xpAwarded = 0,
  });

  factory QuestionAttempt.fromMap(Map<String, dynamic> map) {
    return QuestionAttempt(
      userAnswer: map['userAnswer'] as String,
      isCorrect: map['isCorrect'] as bool,
      attemptedAt: (map['attemptedAt'] as Timestamp).toDate(),
      xpAwarded: map['xpAwarded'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userAnswer': userAnswer,
      'isCorrect': isCorrect,
      'attemptedAt': Timestamp.fromDate(attemptedAt),
      'xpAwarded': xpAwarded,
    };
  }

  QuestionAttempt copyWith({
    String? userAnswer,
    bool? isCorrect,
    DateTime? attemptedAt,
    int? xpAwarded,
  }) {
    return QuestionAttempt(
      userAnswer: userAnswer ?? this.userAnswer,
      isCorrect: isCorrect ?? this.isCorrect,
      attemptedAt: attemptedAt ?? this.attemptedAt,
      xpAwarded: xpAwarded ?? this.xpAwarded,
    );
  }

  @override
  String toString() {
    return 'QuestionAttempt(userAnswer: $userAnswer, isCorrect: $isCorrect, attemptedAt: $attemptedAt, xpAwarded: $xpAwarded)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAttempt &&
          runtimeType == other.runtimeType &&
          userAnswer == other.userAnswer &&
          isCorrect == other.isCorrect &&
          attemptedAt == other.attemptedAt &&
          xpAwarded == other.xpAwarded;

  @override
  int get hashCode =>
      userAnswer.hashCode ^ isCorrect.hashCode ^ attemptedAt.hashCode ^ xpAwarded.hashCode;
}