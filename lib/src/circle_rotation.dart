import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularAnimation extends StatefulWidget {
  const CircularAnimation({Key? key}) : super(key: key);

  @override
  State<CircularAnimation> createState() => _CircularAnimationState();
}

class _CircularAnimationState extends State<CircularAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _circularAnimation;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat(reverse: true);
    _circularAnimation =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat();
    _animation = Tween<double>(begin: 100, end: 150).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _circularAnimation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, snapshot) {
              return Transform.rotate(
                angle: Circles.angleToRadian(360 * _circularAnimation.value),
                child: CustomPaint(
                  painter: Circles(_animation.value),
                  size: const Size(300, 300),
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _circularAnimation.dispose();
    _animationController.dispose();
    super.dispose();
  }
}

class Circles extends CustomPainter {
  final double value;

  Circles(this.value);
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;
    bool isupward = true;
    for (var i = 0; i < 18; i++) {
      canvas.drawCircle(
          Offset(
              getXpoint(center, angleToRadian(20.0 * i),
                  isupward ? value + 30 : 280 - value),
              getYpoint(center, angleToRadian(20.0 * i),
                  isupward ? value + 30 : 280 - value)),
          8,
          Paint()..color = Colors.red);

      canvas.drawCircle(
          Offset(
              getXpoint(center, angleToRadian(20.0 * i),
                  !isupward ? value - 80 : 270 - value - 100),
              getYpoint(center, angleToRadian(20.0 * i),
                  !isupward ? value - 80 : 270 - value - 100)),
          2,
          Paint()..color = Colors.red);

      isupward = !isupward;
    }
    canvas.drawCircle(Offset(center, center), 8, Paint()..color = Colors.red);
  }

  double getXpoint(double center, double angle, double raduis) {
    return center + math.cos(angle) * raduis;
  }

  static double angleToRadian(double angle) {
    return angle * (math.pi / 180);
  }

  double getYpoint(double center, double angle, double raduis) {
    return center + math.sin(angle) * raduis;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
