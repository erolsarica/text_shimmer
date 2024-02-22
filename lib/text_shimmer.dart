import 'dart:math' as math;

import 'package:flutter/material.dart';

class TextShimmer extends StatefulWidget {
  const TextShimmer({
    super.key,
    required this.animationController,
    required this.length,
    required this.char,
    required this.index,
  });
  final AnimationController animationController;
  final int length;
  final String char;
  final int index;

  @override
  State<TextShimmer> createState() => _TextShimmerState();
}

class _TextShimmerState extends State<TextShimmer> {
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    double startValue = (widget.index / widget.length) * 0.5;
    double endValue = math.min(startValue + 0.2, 1.0);
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.25)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.25, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50.0,
      ),
    ]).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(startValue, endValue),
      ),
    );

    _colorAnimation = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(
          begin: const Color(0xFF56CED0),
          end: const Color(0xFFbcfbff),
        ),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: const Color(0xFFbcfbff),
          end: const Color(0xFF3A777B),
        ),
        weight: 50.0,
      ),
    ]).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(startValue, endValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Text(
        widget.char,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: _colorAnimation.value!,
            ),
      ),
    );
  }
}
