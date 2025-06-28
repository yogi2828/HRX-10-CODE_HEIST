// lib/widgets/gamification/level_path_painter.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';

class LevelPathPainter extends CustomPainter {
  final List<Offset> nodePositions;

  LevelPathPainter({required this.nodePositions});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.borderColor.withOpacity(0.5)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final completedPaint = Paint()
      ..color = AppColors.successColor.withOpacity(0.7)
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (nodePositions.length < 2) {
      return;
    }

    Path path = Path();
    path.moveTo(nodePositions[0].dx, nodePositions[0].dy);

    for (int i = 1; i < nodePositions.length; i++) {
      // Draw a quadratic bezier curve for a smoother path
      final controlPointX = (nodePositions[i - 1].dx + nodePositions[i].dx) / 2;
      final controlPointY = nodePositions[i - 1].dy; // Keep Y closer to previous node for a gentle curve

      path.quadraticBezierTo(
        controlPointX,
        controlPointY,
        nodePositions[i].dx,
        nodePositions[i].dy,
      );
    }
    canvas.drawPath(path, paint);

    // Optional: Draw a "completed" path segment in a different color
    // This requires knowing which levels are completed, which is typically handled
    // by passing more granular state down or calculating it here.
    // For now, let's assume we can mark initial segments as completed.
    // This is a placeholder for future enhancement to reflect actual progress.
    if (nodePositions.length > 1) {
      final completedPath = Path();
      completedPath.moveTo(nodePositions[0].dx, nodePositions[0].dy);
      // Example: Mark the first segment as completed if desired
      // You would adapt this based on `isCompleted` status of levels
      if (nodePositions.length > 1) {
         final controlPointX = (nodePositions[0].dx + nodePositions[1].dx) / 2;
         final controlPointY = nodePositions[0].dy;
         completedPath.quadraticBezierTo(
           controlPointX,
           controlPointY,
           nodePositions[1].dx,
           nodePositions[1].dy,
         );
         canvas.drawPath(completedPath, completedPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as LevelPathPainter).nodePositions != nodePositions;
  }
}

