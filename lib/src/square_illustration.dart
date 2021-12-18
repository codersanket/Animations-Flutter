import 'dart:async';

import 'package:flutter/material.dart';

class SquareIllustration extends StatefulWidget {
  const SquareIllustration({Key? key}) : super(key: key);

  @override
  _SquareIllustrationState createState() => _SquareIllustrationState();
}

class _SquareIllustrationState extends State<SquareIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _firstHalf, _secondHalf, _thirdHalf, _fourthHalf;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
    _firstHalf = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.24, curve: Curves.ease));
    _secondHalf = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.26, 0.49, curve: Curves.ease));
    _thirdHalf = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.51, 0.74, curve: Curves.ease));
    _fourthHalf = CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.76, 1.0, curve: Curves.ease));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ClipRect(
          child: SizedBox(
            height: 200,
            width: 200,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, snapshot) => CustomPaint(
                painter: Squares(_animationController, _firstHalf, _secondHalf,
                    _fourthHalf, _thirdHalf),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class Squares extends CustomPainter {
  AnimationController animationController;
  Animation first, second, third, fourth;
  Squares(this.animationController, this.first, this.second, this.fourth,
      this.third);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < 20; i++) {
      late Offset? offset;
      if (animationController.value < 0.25) {
        offset = Offset.lerp(
            Offset(center.dx - (10.0 * i), center.dy - ((10.0 * i))),
            Offset(center.dx + (10.0 * i), center.dy - ((10.0 * i))),
            first.value);
      } else if (animationController.value < 0.51) {
        offset = Offset.lerp(
            Offset(center.dx + (10.0 * i), center.dy - ((10.0 * i))),
            Offset(center.dx + (10.0 * i), center.dy + ((10.0 * i))),
            second.value);
      } else if (animationController.value < 0.74) {
        offset = Offset.lerp(
            Offset(center.dx + (10.0 * i), center.dy + ((10.0 * i))),
            Offset(center.dx - (10.0 * i), center.dy + ((10.0 * i))),
            third.value);
      } else {
        offset = Offset.lerp(
            Offset(center.dx - (10.0 * i), center.dy + ((10.0 * i))),
            Offset(center.dx - (10.0 * i), center.dy - ((10.0 * i))),
            fourth.value);
      }
      canvas.drawRect(
          Rect.fromCenter(
              center: offset!,
              width: 200 - (18.0 * (i)),
              height: 200 - (18.0 * (i))),
          Paint()
            ..color = Color.lerp(Colors.white, Colors.black, (20.0 * i) / 2000)!
            ..style = PaintingStyle.stroke
            ..strokeWidth = 10 / i);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
