// lib/widgets/common/animated_counter.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_constants.dart';

class AnimatedCounter extends StatefulWidget {
  final int value;
  final TextStyle? textStyle;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.textStyle,
    this.duration = AppConstants.longAnimationDuration,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  late int _oldValue;

  @override
  void initState() {
    super.initState();
    _oldValue = widget.value;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = IntTween(begin: _oldValue, end: widget.value).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _oldValue = oldWidget.value;
      _animation = IntTween(begin: _oldValue, end: widget.value).animate(_controller);
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          _animation.value.toString(),
          style: widget.textStyle,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
