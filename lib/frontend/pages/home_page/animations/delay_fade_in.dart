import 'package:flutter/material.dart';

class DelayFadeInEffect extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final double delayAmount;

  const DelayFadeInEffect({
    super.key,
    required this.duration,
    required this.child,
    required this.delayAmount,
  });
  @override
  State<DelayFadeInEffect> createState() => _DelayFadeInEffectState();
}

class _DelayFadeInEffectState extends State<DelayFadeInEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.value = 1.0;
      }
    });

    _animation = _animationController.drive(
      TweenSequence([
        if (widget.delayAmount > 0)
          TweenSequenceItem(
            tween: ConstantTween<double>(0.0),
            weight: widget.delayAmount,
          ),
        TweenSequenceItem(
          tween: Tween(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.easeIn)),
          weight: 1,
        ),
      ]),
    );
  }

  @override
  void didUpdateWidget(covariant DelayFadeInEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.child.key != oldWidget.child.key) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            (1 - _animation.value) * -50, // Slide from left
            0,
          ),
          child: Opacity(
            opacity: _animation.value, // Fade in
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
