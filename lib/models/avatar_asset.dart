// lib/models/avatar_asset.dart
import 'package:flutter/foundation.dart';

@immutable
class AvatarAsset {
  final String id;
  final String name;
  final String assetPath;

  const AvatarAsset({
    required this.id,
    required this.name,
    required this.assetPath,
  });

  factory AvatarAsset.fromMap(Map<String, dynamic> map) {
    return AvatarAsset(
      id: map['id'] as String,
      name: map['name'] as String,
      assetPath: map['assetPath'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'assetPath': assetPath,
    };
  }

  @override
  String toString() {
    return 'AvatarAsset(id: $id, name: $name, assetPath: $assetPath)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvatarAsset &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          assetPath == other.assetPath;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ assetPath.hashCode;
}