// lib/models/community_post.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Comment {
  final String userId;
  final String username;
  final String avatarAssetPath;
  final String content;
  final DateTime timestamp;

  const Comment({
    required this.userId,
    required this.username,
    required this.avatarAssetPath,
    required this.content,
    required this.timestamp,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'] as String,
      username: map['username'] as String,
      avatarAssetPath: map['avatarAssetPath'] as String,
      content: map['content'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'avatarAssetPath': avatarAssetPath,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  @override
  String toString() {
    return 'Comment(userId: $userId, username: $username, avatarAssetPath: $avatarAssetPath, content: $content, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          username == other.username &&
          avatarAssetPath == other.avatarAssetPath &&
          content == other.content &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      userId.hashCode ^
      username.hashCode ^
      avatarAssetPath.hashCode ^
      content.hashCode ^
      timestamp.hashCode;
}

@immutable
class CommunityPost {
  final String id;
  final String userId;
  final String username;
  final String avatarAssetPath;
  final String content;
  final DateTime timestamp;
  final List<String> likedBy;
  final List<Comment> comments;

  const CommunityPost({
    required this.id,
    required this.userId,
    required this.username,
    required this.avatarAssetPath,
    required this.content,
    required this.timestamp,
    this.likedBy = const [],
    this.comments = const [],
  });

  factory CommunityPost.fromMap(Map<String, dynamic> map) {
    return CommunityPost(
      id: map['id'] as String,
      userId: map['userId'] as String,
      username: map['username'] as String,
      avatarAssetPath: map['avatarAssetPath'] as String,
      content: map['content'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      likedBy: List<String>.from(map['likedBy'] ?? []),
      comments: (map['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'avatarAssetPath': avatarAssetPath,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
      'likedBy': likedBy,
      'comments': comments.map((e) => e.toMap()).toList(),
    };
  }

  CommunityPost copyWith({
    String? id,
    String? userId,
    String? username,
    String? avatarAssetPath,
    String? content,
    DateTime? timestamp,
    List<String>? likedBy,
    List<Comment>? comments,
  }) {
    return CommunityPost(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatarAssetPath: avatarAssetPath ?? this.avatarAssetPath,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      likedBy: likedBy ?? this.likedBy,
      comments: comments ?? this.comments,
    );
  }

  @override
  String toString() {
    return 'CommunityPost(id: $id, userId: $userId, username: $username, avatarAssetPath: $avatarAssetPath, content: $content, timestamp: $timestamp, likedBy: $likedBy, comments: $comments)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityPost &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          username == other.username &&
          avatarAssetPath == other.avatarAssetPath &&
          content == other.content &&
          timestamp == other.timestamp &&
          listEquals(likedBy, other.likedBy) &&
          listEquals(comments, other.comments);

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      username.hashCode ^
      avatarAssetPath.hashCode ^
      content.hashCode ^
      timestamp.hashCode ^
      listEquals(likedBy, likedBy).hashCode ^
      listEquals(comments, comments).hashCode;
}
