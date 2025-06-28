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
