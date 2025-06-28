// lib/widgets/gamification/level_path_painter.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/models/level.dart';

class LevelPathPainter extends CustomPainter {
  final List<Level> levels;
  final Map<String, Offset> levelPositions;
  final Map<String, bool> levelCompletionStatus;
  final double nodeSize; // Added nodeSize to correctly calculate center points

  LevelPathPainter({
    required this.levels,
    required this.levelPositions,
    required this.levelCompletionStatus,
    this.nodeSize = 120.0, // Default node size, ensure it matches LevelNode
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint completedPathPaint = Paint()
      ..color = AppColors.successColor
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint upcomingPathPaint = Paint()
      ..color = AppColors.borderColor.withOpacity(0.7) // Darker for visibility
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < levels.length - 1; i++) {
      final Level currentLevel = levels[i];
      final Level nextLevel = levels[i + 1];

      final Offset? startNodeTopLeft = levelPositions[currentLevel.id];
      final Offset? endNodeTopLeft = levelPositions[nextLevel.id];

      if (startNodeTopLeft != null && endNodeTopLeft != null) {
        // Calculate center points of the nodes
        final Offset startPoint = Offset(startNodeTopLeft.dx + nodeSize / 2, startNodeTopLeft.dy + nodeSize / 2);
        final Offset endPoint = Offset(endNodeTopLeft.dx + nodeSize / 2, endNodeTopLeft.dy + nodeSize / 2);

        final bool isCurrentLevelCompleted = levelCompletionStatus[currentLevel.id] ?? false;

        final path = Path();
        path.moveTo(startPoint.dx, startPoint.dy);

        // Determine if current level is on the left or right column
        bool currentIsLeft = startNodeTopLeft.dx < size.width / 2;

        // Calculate a control point for a smooth zigzag curve
        // This creates a "bend" in the middle of the line segment
        final double midX = (startPoint.dx + endPoint.dx) / 2;
        final double midY = (startPoint.dy + endPoint.dy) / 2;

        final double controlX;
        final double controlY;

        if (currentIsLeft) {
          // If current is left, and next is right, control point goes down-right from midpoint
          controlX = midX + 60; // Offset control point horizontally
          controlY = midY + 40; // Offset control point vertically
        } else {
          // If current is right, and next is left, control point goes down-left from midpoint
          controlX = midX - 60;
          controlY = midY + 40;
        }

        path.quadraticBezierTo(controlX, controlY, endPoint.dx, endPoint.dy);

        if (isCurrentLevelCompleted) {
          canvas.drawPath(path, completedPathPaint);
        } else {
          canvas.drawPath(path, upcomingPathPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    LevelPathPainter oldPainter = oldDelegate as LevelPathPainter;
    return levels != oldPainter.levels ||
        levelPositions != oldPainter.levelPositions ||
        levelCompletionStatus != oldPainter.levelCompletionStatus ||
        nodeSize != oldPainter.nodeSize;
  }
}