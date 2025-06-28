// lib/models/user_profile.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamifier/constants/app_constants.dart';

class UserProfile {
  final String uid;
  final String username;
  final String email;
  final String avatarAssetPath;
  final int xp;
  final int level;
  final int currentStreak;
  final DateTime lastLoginDate;
  final DateTime createdAt;
  final String? educationLevel;
  final String? specialty;
  final List<String> earnedBadges;
  final List<String> friends;

  UserProfile({
    required this.uid,
    required this.username,
    this.email = '',
    this.avatarAssetPath = 'assets/avatars/avatar1.png',
    this.xp = AppConstants.initialXp,
    this.level = 1,
    this.currentStreak = 0,
    required this.lastLoginDate,
    required this.createdAt,
    this.educationLevel,
    this.specialty,
    this.earnedBadges = const [],
    this.friends = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'avatarAssetPath': avatarAssetPath,
      'xp': xp,
      'level': level,
      'currentStreak': currentStreak,
      'lastLoginDate': Timestamp.fromDate(lastLoginDate),
      'createdAt': Timestamp.fromDate(createdAt),
      'educationLevel': educationLevel,
      'specialty': specialty,
      'earnedBadges': earnedBadges,
      'friends': friends,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] as String,
      username: map['username'] as String,
      email: map['email'] as String? ?? '',
      avatarAssetPath: map['avatarAssetPath'] as String? ?? 'assets/avatars/avatar1.png',
      xp: map['xp'] as int? ?? AppConstants.initialXp,
      level: map['level'] as int? ?? 1,
      currentStreak: map['currentStreak'] as int? ?? 0,
      lastLoginDate: (map['lastLoginDate'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      educationLevel: map['educationLevel'] as String?,
      specialty: map['specialty'] as String?,
      earnedBadges: List<String>.from(map['earnedBadges'] as List? ?? []),
      friends: List<String>.from(map['friends'] as List? ?? []),
    );
  }

  UserProfile copyWith({
    String? uid,
    String? username,
    String? email,
    String? avatarAssetPath,
    int? xp,
    int? level,
    int? currentStreak,
    DateTime? lastLoginDate,
    DateTime? createdAt,
    String? educationLevel,
    String? specialty,
    List<String>? earnedBadges,
    List<String>? friends,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarAssetPath: avatarAssetPath ?? this.avatarAssetPath,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      currentStreak: currentStreak ?? this.currentStreak,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      createdAt: createdAt ?? this.createdAt,
      educationLevel: educationLevel ?? this.educationLevel,
      specialty: specialty ?? this.specialty,
      earnedBadges: earnedBadges ?? this.earnedBadges,
      friends: friends ?? this.friends,
    );
  }
}