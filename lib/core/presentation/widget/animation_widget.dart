import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({
    super.key,
    required this.child,
    required this.animationType,
    this.duration,
    this.begin,
  });

  final Widget child;
  final String animationType;
  final Duration? duration;
  final Offset? begin;

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: widget.duration ?? const Duration(seconds: 1))
      ..forward();
    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    scaleAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    slideAnimation = Tween<Offset>(
      begin: widget.begin ?? const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.animationType == 'FADE'
        ? FadeTransition(
            opacity: fadeAnimation,
            child: widget.child,
          )
        : widget.animationType == 'SCALE'
            ? ScaleTransition(
                scale: scaleAnimation,
                child: widget.child,
              )
            : SlideTransition(
                position: slideAnimation,
                child: widget.child,
              );
  }
}
