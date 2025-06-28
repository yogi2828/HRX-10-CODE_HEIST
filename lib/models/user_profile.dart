// lib/models/user_profile.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/avatar_asset.dart';

@immutable
class UserProfile {
  final String uid;
  final String username;
  final int xp;
  final int level;
  final String avatarAssetPath;
  final List<String> earnedBadges;
  final DateTime createdAt;
  final String? educationLevel;
  final String? specialty;
  final List<String> friends;
  final int currentStreak;
  final DateTime? lastStreakUpdate;
  final String? aiPersona; // New: AI Persona

  UserProfile({
    required this.uid,
    required this.username,
    this.xp = AppConstants.initialXp,
    this.level = 1,
    String? avatarAssetPath,
    this.earnedBadges = const [],
    required this.createdAt,
    this.educationLevel,
    this.specialty,
    this.friends = const [],
    this.currentStreak = AppConstants.initialStreak,
    this.lastStreakUpdate,
    this.aiPersona, // New: AI Persona
  }) : this.avatarAssetPath = avatarAssetPath ??
            (AppConstants.defaultAvatarAssets.isNotEmpty
                ? AppConstants.defaultAvatarAssets.first.assetPath
                : 'assets/avatars/default.png');

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] as String,
      username: map['username'] as String,
      xp: (map['xp'] ?? AppConstants.initialXp) as int,
      level: (map['level'] ?? 1) as int,
      avatarAssetPath: (map['avatarAssetPath'] ??
          (AppConstants.defaultAvatarAssets.isNotEmpty
              ? AppConstants.defaultAvatarAssets.first.assetPath
              : 'assets/avatars/default.png')) as String,
      earnedBadges: List<String>.from(map['earnedBadges'] ?? []),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      educationLevel: map['educationLevel'] as String?,
      specialty: map['specialty'] as String?,
      friends: List<String>.from(map['friends'] ?? []),
      currentStreak: (map['currentStreak'] ?? AppConstants.initialStreak) as int,
      lastStreakUpdate: (map['lastStreakUpdate'] as Timestamp?)?.toDate(),
      aiPersona: map['aiPersona'] as String?, // New: AI Persona
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'xp': xp,
      'level': level,
      'avatarAssetPath': avatarAssetPath,
      'earnedBadges': earnedBadges,
      'createdAt': Timestamp.fromDate(createdAt),
      'educationLevel': educationLevel,
      'specialty': specialty,
      'friends': friends,
      'currentStreak': currentStreak,
      'lastStreakUpdate': lastStreakUpdate != null ? Timestamp.fromDate(lastStreakUpdate!) : null,
      'aiPersona': aiPersona, // New: AI Persona
    };
  }

  UserProfile copyWith({
    String? uid,
    String? username,
    int? xp,
    int? level,
    String? avatarAssetPath,
    List<String>? earnedBadges,
    DateTime? createdAt,
    String? educationLevel,
    String? specialty,
    List<String>? friends,
    int? currentStreak,
    DateTime? lastStreakUpdate,
    String? aiPersona, // New: AI Persona
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      avatarAssetPath: avatarAssetPath ?? this.avatarAssetPath,
      earnedBadges: earnedBadges ?? this.earnedBadges,
      createdAt: createdAt ?? this.createdAt,
      educationLevel: educationLevel ?? this.educationLevel,
      specialty: specialty ?? this.specialty,
      friends: friends ?? this.friends,
      currentStreak: currentStreak ?? this.currentStreak,
      lastStreakUpdate: lastStreakUpdate ?? this.lastStreakUpdate,
      aiPersona: aiPersona ?? this.aiPersona, // New: AI Persona
    );
  }

  @override
  String toString() {
    return 'UserProfile(uid: $uid, username: $username, xp: $xp, level: $level, avatarAssetPath: $avatarAssetPath, earnedBadges: $earnedBadges, createdAt: $createdAt, educationLevel: $educationLevel, specialty: $specialty, friends: $friends, currentStreak: $currentStreak, lastStreakUpdate: $lastStreakUpdate, aiPersona: $aiPersona)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          username == other.username &&
          xp == other.xp &&
          level == other.level &&
          avatarAssetPath == other.avatarAssetPath &&
          listEquals(earnedBadges, other.earnedBadges) &&
          createdAt == other.createdAt &&
          educationLevel == other.educationLevel &&
          specialty == other.specialty &&
          listEquals(friends, other.friends) &&
          currentStreak == other.currentStreak &&
          lastStreakUpdate == other.lastStreakUpdate &&
          aiPersona == other.aiPersona; // New: AI Persona

  @override
  int get hashCode =>
      uid.hashCode ^
      username.hashCode ^
      xp.hashCode ^
      level.hashCode ^
      avatarAssetPath.hashCode ^
      listEquals(earnedBadges, earnedBadges).hashCode ^
      createdAt.hashCode ^
      educationLevel.hashCode ^
      specialty.hashCode ^
      listEquals(friends, friends).hashCode ^
      currentStreak.hashCode ^
      lastStreakUpdate.hashCode ^
      (aiPersona?.hashCode ?? 0); // New: AI Persona
}
