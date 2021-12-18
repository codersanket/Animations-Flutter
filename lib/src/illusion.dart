import 'dart:math';

import 'package:flutter/material.dart';

class Illusion extends StatefulWidget {
  const Illusion({Key? key}) : super(key: key);

  @override
  _IllusionState createState() => _IllusionState();
}

class _IllusionState extends State<Illusion> with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
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
                angle: _animationController.value * pi * 2,
                child: CustomPaint(
                  painter: Circles(),
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

class Circles extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < 200; i++) {
      canvas.drawCircle(
          Offset(getXpoint(i * 5, i * 3, center.dx),
              getYpoint(i * 5, i * 3, center.dy)),
          (i * 10.0).clamp(0, 10),
          Paint()..color = Colors.green);
    }
  }

  double getXpoint(double angle, double raduis, double xPoint) {
    return xPoint + cos(angleToRadian(angle)) * raduis;
  }

  double getYpoint(double angle, double raduis, double yPoint) {
    return yPoint + sin(angleToRadian(angle)) * raduis;
  }

  double angleToRadian(double angle) {
    return angle * (pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
