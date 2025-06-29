
// gamifier/lib/widgets/common/flash_card.dart
import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'dart:math' as math;

import 'package:gamifier/widgets/common/custom_button.dart';

class FlashCard extends StatefulWidget {
  final String frontText;
  final String backText;
  final VoidCallback? onFlip;
  final VoidCallback? onNext; // Callback for "Next" action

  const FlashCard({
    super.key,
    required this.frontText,
    required this.backText,
    this.onFlip,
    this.onNext,
  });

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.defaultAnimationDuration * 2, // Slower flip
    );
    _animation = Tween<double>(begin: 0, end: math.pi).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.isAnimating) return;

    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
    widget.onFlip?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(_animation.value),
        child: Container(
          width: 300, // Fixed width for flashcard
          height: 200, // Fixed height for flashcard
          decoration: BoxDecoration(
            color: AppColors.cardColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            gradient: _isFront ? null : AppColors.buttonGradient(), // Gradient on back
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColorDark.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: AppColors.accentColor.withOpacity(0.7),
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: _animation.value <= math.pi / 2
                    ? _buildFront()
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(math.pi),
                        child: _buildBack(),
                      ),
              ),
              if (!_isFront && widget.onNext != null) // Show next button only on back side
                Positioned(
                  bottom: AppConstants.spacing,
                  right: AppConstants.spacing,
                  child: CustomButton(
                    text: 'Next',
                    icon: Icons.arrow_forward_ios_rounded,
                    onPressed: widget.onNext!,
                    isSecondary: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: const TextStyle(fontSize: 14, color: AppColors.accentColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: AppColors.accentColor, size: AppConstants.iconSize * 1.5),
          const SizedBox(height: AppConstants.spacing),
          Flexible(
            child: Text(
              widget.frontText,
              textAlign: TextAlign.center,
              style: AppColors.neonTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
                blurRadius: 5,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline_rounded, color: AppColors.successColor, size: AppConstants.iconSize * 1.5),
          const SizedBox(height: AppConstants.spacing),
          Flexible(
            child: Text(
              widget.backText,
              textAlign: TextAlign.center,
              style: AppColors.neonTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.textColor,
                blurRadius: 3,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}




