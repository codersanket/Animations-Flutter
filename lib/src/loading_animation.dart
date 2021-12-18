import 'dart:math';

import 'package:flutter/material.dart';

import 'package:animation/utils/utills.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _animation = Tween<double>(begin: 10, end: 70).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, snapshot) {
              return Transform.rotate(
                angle: _animationController.value * (pi * 2),
                child: CustomPaint(
                  painter: LoadingPainter(animation: _animation),
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class LoadingPainter extends CustomPainter {
  final Animation animation;
  LoadingPainter({
    required this.animation,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    for (var i = 1; i < 5; i++) {
      for (var j = 0; j < 4; j++) {
        canvas.drawArc(
            Rect.fromCenter(center: center, width: i * 80, height: i * 80),
            Uttils.angleToRadian(90.0 * j),
            Uttils.angleToRadian(animation.value),
            false,
            paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
