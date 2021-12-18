import 'dart:math';

import 'package:flutter/material.dart';

class CircularIllusion extends StatefulWidget {
  const CircularIllusion({Key? key}) : super(key: key);

  @override
  State<CircularIllusion> createState() => _CircularIllusionState();
}

class _CircularIllusionState extends State<CircularIllusion>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: animationController,
          builder: (context, snapshot) {
            return Transform.rotate(
              angle: animationController.value * (pi * 2),
              child: CustomPaint(
                painter: CircularIllusionPainter(),
                size: Size.infinite,
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class CircularIllusionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < 360; i++) {
      canvas.drawCircle(
          Offset(getXpoint(center.dx, angleToRadian(i * 2.5), i * 1.5),
              getYpoint(center.dy, angleToRadian(i * 2.5), i * 1.5)),
          6,
          Paint()..color = Colors.green);
    }
  }

  double getXpoint(double center, double angle, double raduis) {
    return center + cos(angle) * raduis;
  }

  static double angleToRadian(double angle) {
    return angle * (pi / 180);
  }

  double getYpoint(double center, double angle, double raduis) {
    return center + sin(angle) * raduis;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
