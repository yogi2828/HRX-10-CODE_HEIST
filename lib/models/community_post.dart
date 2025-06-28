// lib/models/community_post.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class CommunityPost {
  final String id;
  final String authorId;
  final String authorUsername;
  final String authorAvatarUrl;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  final List<String> likedBy;
  final List<Comment> comments;

  const CommunityPost({
    required this.id,
    required this.authorId,
    required this.authorUsername,
    required this.authorAvatarUrl,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    this.likedBy = const [],
    this.comments = const [],
  });

  factory CommunityPost.fromMap(Map<String, dynamic> map) {
    return CommunityPost(
      id: map['id'] as String,
      authorId: map['authorId'] as String,
      authorUsername: map['authorUsername'] as String,
      authorAvatarUrl: map['authorAvatarUrl'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String?,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      likedBy: List<String>.from(map['likedBy'] ?? []),
      comments: (map['comments'] as List<dynamic>?)
              ?.map((c) => Comment.fromMap(c as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorId': authorId,
      'authorUsername': authorUsername,
      'authorAvatarUrl': authorAvatarUrl,
      'content': content,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.fromDate(timestamp),
      'likedBy': likedBy,
      'comments': comments.map((c) => c.toMap()).toList(),
    };
  }

  CommunityPost copyWith({
    String? id,
    String? authorId,
    String? authorUsername,
    String? authorAvatarUrl,
    String? content,
    String? imageUrl,
    DateTime? timestamp,
    List<String>? likedBy,
    List<Comment>? comments,
  }) {
    return CommunityPost(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorUsername: authorUsername ?? this.authorUsername,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
      likedBy: likedBy ?? this.likedBy,
      comments: comments ?? this.comments,
    );
  }

  @override
  String toString() {
    return 'CommunityPost(id: $id, authorId: $authorId, authorUsername: $authorUsername, content: $content, imageUrl: $imageUrl, timestamp: $timestamp, likedBy: $likedBy, comments: $comments)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityPost &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          authorId == other.authorId &&
          authorUsername == other.authorUsername &&
          authorAvatarUrl == other.authorAvatarUrl &&
          content == other.content &&
          imageUrl == other.imageUrl &&
          timestamp == other.timestamp &&
          listEquals(likedBy, other.likedBy) &&
          listEquals(comments, other.comments);

  @override
  int get hashCode =>
      id.hashCode ^
      authorId.hashCode ^
      authorUsername.hashCode ^
      authorAvatarUrl.hashCode ^
      content.hashCode ^
      imageUrl.hashCode ^
      timestamp.hashCode ^
      listEquals(likedBy, likedBy).hashCode ^
      listEquals(comments, comments).hashCode;
}

@immutable
class Comment {
  final String id;
  final String userId;
  final String username;
  final String avatarUrl;
  final String text;
  final DateTime timestamp;

  const Comment({
    required this.id,
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.text,
    required this.timestamp,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      userId: map['userId'] as String,
      username: map['username'] as String,
      avatarUrl: map['avatarUrl'] as String,
      text: map['text'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'avatarUrl': avatarUrl,
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  @override
  String toString() {
    return 'Comment(id: $id, userId: $userId, username: $username, text: $text, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          username == other.username &&
          avatarUrl == other.avatarUrl &&
          text == other.text &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ username.hashCode ^ avatarUrl.hashCode ^ text.hashCode ^ timestamp.hashCode;
}