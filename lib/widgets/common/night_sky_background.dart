// lib/widgets/background/night_sky_background.dart (New File)
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:gamifier/constants/app_colors.dart';

class NightSkyBackground extends StatefulWidget {
  final Widget child;

  const NightSkyBackground({super.key, required this.child});

  @override
  State<NightSkyBackground> createState() => _NightSkyBackgroundState();
}

class _NightSkyBackgroundState extends State<NightSkyBackground> with TickerProviderStateMixin {
  late AnimationController _starController;
  late Animation<double> _starAnimation;
  late AnimationController _bubbleController;
  final List<Bubble> _bubbles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // Star animation
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
    _starAnimation = Tween<double>(begin: 0, end: 1).animate(_starController);

    // Bubble animation
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        if (_bubbleController.isCompleted) {
          _bubbleController.repeat();
        }
        _updateBubbles();
      });
    _bubbleController.repeat();

    _createInitialBubbles();
  }

  void _createInitialBubbles() {
    for (int i = 0; i < 20; i++) {
      _bubbles.add(Bubble(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 5 + 2,
        speed: _random.nextDouble() * 0.005 + 0.001,
        opacity: _random.nextDouble() * 0.5 + 0.3,
      ));
    }
  }

  void _updateBubbles() {
    setState(() {
      for (int i = 0; i < _bubbles.length; i++) {
        _bubbles[i].y -= _bubbles[i].speed;
        if (_bubbles[i].y < -0.1) {
          _bubbles[i] = Bubble(
            x: _random.nextDouble(),
            y: 1.1, // Reset from bottom
            size: _random.nextDouble() * 5 + 2,
            speed: _random.nextDouble() * 0.005 + 0.001,
            opacity: _random.nextDouble() * 0.5 + 0.3,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _starController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryColorDark,
                AppColors.primaryColor,
                AppColors.backgroundColor,
              ],
            ),
          ),
        ),
        // Animated Stars
        AnimatedBuilder(
          animation: _starAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: StarPainter(_starAnimation.value),
              child: Container(),
            );
          },
        ),
        // Animated Bubbles
        ..._bubbles.map((bubble) => Positioned.fill(
              child: Align(
                alignment: Alignment(
                    (bubble.x * 2) - 1, (bubble.y * 2) - 1), // Convert 0-1 to -1 to 1
                child: Opacity(
                  opacity: bubble.opacity,
                  child: Container(
                    width: bubble.size,
                    height: bubble.size,
                    decoration: BoxDecoration(
                      color: AppColors.bubbleColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            )),
        // Main content
        widget.child,
      ],
    );
  }
}

class StarPainter extends CustomPainter {
  final double animationValue;
  final Random _random = Random();

  StarPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.starColor.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    // Draw multiple stars
    for (int i = 0; i < 100; i++) {
      final x = _random.nextDouble() * size.width;
      final y = _random.nextDouble() * size.height;
      final radius = _random.nextDouble() * 1.5 + 0.5; // Small stars
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Simulate twinkling by slightly changing opacity or size based on animation value
    for (int i = 0; i < 50; i++) {
      final x = _random.nextDouble() * size.width;
      final y = _random.nextDouble() * size.height;
      final radius = (_random.nextDouble() * 2 + 1) * (0.5 + 0.5 * sin(animationValue * pi * 2 + i / 10)); // Larger stars with twinkling
      paint.color = AppColors.starColor.withOpacity(0.5 + 0.5 * cos(animationValue * pi * 2 + i / 5));
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint for continuous animation
  }
}

class Bubble {
  double x;
  double y;
  double size;
  double speed;
  double opacity;

  Bubble({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}
