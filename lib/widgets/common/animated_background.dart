// gamifier/lib/widgets/common/animated_background.dart
import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
  late List<Star> _stars;
  late List<Sphere> _spheres; // New: for the 'balls'
  late List<AnimationController> _starControllers;
  late List<Animation<Offset>> _starAnimations;
  late List<AnimationController> _sphereControllers;
  late List<Animation<double>> _sphereRotations; // Rotation animation for spheres
  late List<Animation<Offset>> _sphereMovements; // Movement animation for spheres
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // Initialize stars
    _stars = List.generate(100, (index) => Star(_random)); // More stars for web
    _starControllers = [];
    _starAnimations = [];
    for (int i = 0; i < _stars.length; i++) {
      final controller = AnimationController(
        duration: Duration(seconds: _random.nextInt(20) + 30), // 30-50 seconds for slower movement
        vsync: this,
      )..repeat(reverse: true);
      _starControllers.add(controller);

      final startOffset = Offset(_random.nextDouble() * 2 - 1, _random.nextDouble() * 2 - 1);
      final endOffset = Offset(_random.nextDouble() * 2 - 1, _random.nextDouble() * 2 - 1);

      _starAnimations.add(
        Tween<Offset>(begin: startOffset, end: endOffset).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOutSine,
          ),
        ),
      );
    }

    // Initialize spheres (balls)
    _spheres = List.generate(5, (index) => Sphere(_random)); // 5 large, slowly rotating spheres
    _sphereControllers = [];
    _sphereRotations = [];
    _sphereMovements = [];
    for (int i = 0; i < _spheres.length; i++) {
      final controller = AnimationController(
        duration: Duration(seconds: _random.nextInt(60) + 90), // 90-150 seconds for very slow rotation
        vsync: this,
      )..repeat(reverse: false); // Continuous rotation
      _sphereControllers.add(controller);

      _sphereRotations.add(
        Tween<double>(begin: 0, end: 2 * pi).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.linear, // Constant rotation speed
          ),
        ),
      );

      final startOffset = Offset(_random.nextDouble() * 2 - 1, _random.nextDouble() * 2 - 1);
      final endOffset = Offset(_random.nextDouble() * 2 - 1, _random.nextDouble() * 2 - 1);
      _sphereMovements.add(
        Tween<Offset>(begin: startOffset, end: endOffset).animate(
          CurvedAnimation(
            parent: controller, // Use the same controller for movement
            curve: Curves.easeInOutQuad, // Smooth movement
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _starControllers) {
      controller.dispose();
    }
    for (var controller in _sphereControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark space/galaxy background color
        Container(
          color: Colors.black, // Solid black for deep space
        ),
        // Animated stars
        ...List.generate(_stars.length, (index) {
          return AnimatedBuilder(
            animation: _starAnimations[index],
            builder: (context, child) {
              final double screenWidth = MediaQuery.of(context).size.width;
              final double screenHeight = MediaQuery.of(context).size.height;

              final double offsetX = screenWidth * (_stars[index].initialPosition.dx + _starAnimations[index].value.dx * 0.5);
              final double offsetY = screenHeight * (_stars[index].initialPosition.dy + _starAnimations[index].value.dy * 0.5);

              return Positioned(
                left: offsetX,
                top: offsetY,
                child: Opacity(
                  opacity: _stars[index].opacity,
                  child: Container(
                    width: _stars[index].size,
                    height: _stars[index].size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _stars[index].color.withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: _stars[index].color.withOpacity(0.4),
                          blurRadius: _stars[index].size / 3,
                          spreadRadius: _stars[index].size / 6,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
        // Animated spheres (balls)
        ...List.generate(_spheres.length, (index) {
          return AnimatedBuilder(
            animation: _sphereControllers[index],
            builder: (context, child) {
              final double screenWidth = MediaQuery.of(context).size.width;
              final double screenHeight = MediaQuery.of(context).size.height;

              final double movementOffsetX = screenWidth * (_spheres[index].initialPosition.dx + _sphereMovements[index].value.dx * 0.2); // Slower movement
              final double movementOffsetY = screenHeight * (_spheres[index].initialPosition.dy + _sphereMovements[index].value.dy * 0.2);

              return Positioned(
                left: movementOffsetX,
                top: movementOffsetY,
                child: Transform.rotate(
                  angle: _sphereRotations[index].value,
                  child: Opacity(
                    opacity: _spheres[index].opacity,
                    child: Container(
                      width: _spheres[index].size,
                      height: _spheres[index].size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient( // Radial gradient for a spherical look
                          colors: [
                            _spheres[index].color.withOpacity(0.7),
                            _spheres[index].color.withOpacity(0.3),
                          ],
                          stops: const [0.0, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _spheres[index].color.withOpacity(0.5),
                            blurRadius: _spheres[index].size / 2,
                            spreadRadius: _spheres[index].size / 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
        // Main app content
        widget.child,
      ],
    );
  }
}

class Star {
  final Random random;
  final double size;
  final Color color;
  final double opacity;
  final Offset initialPosition;

  Star(this.random)
      : size = random.nextDouble() * 2 + 1, // Stars from 1 to 3 pixels
        color = Colors.white.withOpacity(random.nextDouble() * 0.5 + 0.5),
        opacity = random.nextDouble() * 0.7 + 0.3,
        initialPosition = Offset(random.nextDouble(), random.nextDouble());
}

class Sphere {
  final Random random;
  final double size;
  final Color color;
  final double opacity;
  final Offset initialPosition;

  Sphere(this.random)
      : size = random.nextDouble() * 20 + 30, // Spheres from 30 to 50 pixels
        color = _getRandomColor(random), // Dynamic colors for spheres
        opacity = random.nextDouble() * 0.4 + 0.3, // More transparent
        initialPosition = Offset(random.nextDouble(), random.nextDouble());

  static Color _getRandomColor(Random random) {
    final colors = [
      Colors.blue.shade300,
      Colors.purple.shade300,
      Colors.cyan.shade300,
      Colors.pink.shade300,
      Colors.amber.shade300,
    ];
    return colors[random.nextInt(colors.length)];
  }
}