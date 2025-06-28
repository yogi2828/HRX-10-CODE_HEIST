// lib/models/user_profile.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gamifier/models/badge.dart'; // Ensure Badge is imported if used directly here, though typically its ID is stored

@immutable
class UserProfile {
  final String uid;
  final String username;
  final String email;
  final String avatarAssetPath;
  final int xp;
  final int level;
  final DateTime createdAt;
  final DateTime? lastLoginDate;
  final int currentStreak;
  final List<String> earnedBadges;
  final List<String> friends;
  final String? educationLevel; // Made nullable for flexibility if not set
  final String? specialty;      // Made nullable for flexibility if not set
  final String? language;       // New: User's preferred language

  const UserProfile({
    required this.uid,
    required this.username,
    required this.email,
    required this.avatarAssetPath,
    required this.xp,
    required this.level,
    required this.createdAt,
    this.lastLoginDate,
    required this.currentStreak,
    required this.earnedBadges,
    required this.friends,
    this.educationLevel,
    this.specialty,
    this.language, // Initialize new field
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      avatarAssetPath: map['avatarAssetPath'] as String,
      xp: map['xp'] as int,
      level: map['level'] as int,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLoginDate: (map['lastLoginDate'] as Timestamp?)?.toDate(),
      currentStreak: map['currentStreak'] as int,
      earnedBadges: List<String>.from(map['earnedBadges'] ?? []),
      friends: List<String>.from(map['friends'] ?? []),
      educationLevel: map['educationLevel'] as String?,
      specialty: map['specialty'] as String?,
      language: map['language'] as String?, // Read the new field
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'avatarAssetPath': avatarAssetPath,
      'xp': xp,
      'level': level,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLoginDate': lastLoginDate != null ? Timestamp.fromDate(lastLoginDate!) : null,
      'currentStreak': currentStreak,
      'earnedBadges': earnedBadges,
      'friends': friends,
      'educationLevel': educationLevel,
      'specialty': specialty,
      'language': language, // Include the new field
    };
  }

  UserProfile copyWith({
    String? uid,
    String? username,
    String? email,
    String? avatarAssetPath,
    int? xp,
    int? level,
    DateTime? createdAt,
    DateTime? lastLoginDate,
    int? currentStreak,
    List<String>? earnedBadges,
    List<String>? friends,
    String? educationLevel,
    String? specialty,
    String? language, // Update copyWith
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarAssetPath: avatarAssetPath ?? this.avatarAssetPath,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      currentStreak: currentStreak ?? this.currentStreak,
      earnedBadges: earnedBadges ?? this.earnedBadges,
      friends: friends ?? this.friends,
      educationLevel: educationLevel ?? this.educationLevel,
      specialty: specialty ?? this.specialty,
      language: language ?? this.language, // Copy the new field
    );
  }

  @override
  String toString() {
    return 'UserProfile(uid: $uid, username: $username, email: $email, avatarAssetPath: $avatarAssetPath, xp: $xp, level: $level, createdAt: $createdAt, lastLoginDate: $lastLoginDate, currentStreak: $currentStreak, earnedBadges: $earnedBadges, friends: $friends, educationLevel: $educationLevel, specialty: $specialty, language: $language)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          username == other.username &&
          email == other.email &&
          avatarAssetPath == other.avatarAssetPath &&
          xp == other.xp &&
          level == other.level &&
          createdAt == other.createdAt &&
          lastLoginDate == other.lastLoginDate &&
          currentStreak == other.currentStreak &&
          listEquals(earnedBadges, other.earnedBadges) &&
          listEquals(friends, other.friends) &&
          educationLevel == other.educationLevel &&
          specialty == other.specialty &&
          language == other.language; // Compare new field

  @override
  int get hashCode =>
      uid.hashCode ^
      username.hashCode ^
      email.hashCode ^
      avatarAssetPath.hashCode ^
      xp.hashCode ^
      level.hashCode ^
      createdAt.hashCode ^
      (lastLoginDate?.hashCode ?? 0) ^
      currentStreak.hashCode ^
      listEquals(earnedBadges, earnedBadges).hashCode ^
      listEquals(friends, friends).hashCode ^
      (educationLevel?.hashCode ?? 0) ^
      (specialty?.hashCode ?? 0) ^
      (language?.hashCode ?? 0); // Include new field in hash code
}
