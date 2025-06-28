// lib/models/chat_message.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class ChatMessage {
  final String id;
  final String senderId;
  final String senderUsername;
  final String senderAvatarUrl;
  final String text;
  final DateTime timestamp;
  final bool isUser;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderUsername,
    required this.senderAvatarUrl,
    required this.text,
    required this.timestamp,
    required this.isUser,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as String,
      senderId: map['senderId'] as String,
      senderUsername: map['senderUsername'] as String,
      senderAvatarUrl: map['senderAvatarUrl'] as String,
      text: map['text'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      isUser: map['isUser'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'senderUsername': senderUsername,
      'senderAvatarUrl': senderAvatarUrl,
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
      'isUser': isUser,
    };
  }

  @override
  String toString() {
    return 'ChatMessage(id: $id, senderId: $senderId, senderUsername: $senderUsername, text: $text, timestamp: $timestamp, isUser: $isUser)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          senderId == other.senderId &&
          senderUsername == other.senderUsername &&
          senderAvatarUrl == other.senderAvatarUrl &&
          text == other.text &&
          timestamp == other.timestamp &&
          isUser == other.isUser;

  @override
  int get hashCode =>
      id.hashCode ^
      senderId.hashCode ^
      senderUsername.hashCode ^
      senderAvatarUrl.hashCode ^
      text.hashCode ^
      timestamp.hashCode ^
      isUser.hashCode;
}