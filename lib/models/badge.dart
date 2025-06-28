// lib/models/badge.dart
import 'package:flutter/foundation.dart';

@immutable
class Badge {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  const Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Badge.fromMap(Map<String, dynamic> map) {
    return Badge(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  @override
  String toString() {
    return 'Badge(id: $id, name: $name, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Badge &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode ^ imageUrl.hashCode;
}
