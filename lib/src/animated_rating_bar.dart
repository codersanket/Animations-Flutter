import 'dart:developer';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math.dart' as vc;

class AnimatedRatingBar extends StatelessWidget {
  const AnimatedRatingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RenderWidget(),
    );
  }
}

class RenderWidget extends LeafRenderObjectWidget {
  const RenderWidget({Key? key}) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) => RenderPage();
}

class RenderPage extends RenderBox {
  RenderPage() {
    drag = PanGestureRecognizer()
      ..onStart = _onStart
      ..onUpdate = _onUpdate
      ..onEnd = _onEnd;
  }
  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Offset _location = sliderPostion;

  late PanGestureRecognizer drag;
  @override
  bool hitTestSelf(Offset position) {
    return checkPostion(position);
  }

  bool checkPostion(Offset postion) {
    if (postion.dy > sliderPostion.dy - 30 &&
        postion.dy < sliderPostion.dy + 30 &&
        postion.dx > 40 &&
        postion.dx < size.width - 40) {
      return true;
    }
    return false;
  }

  Color color = Colors.yellowAccent;

  _onStart(DragStartDetails details) {
    if (checkPostion(details.localPosition)) {
      _location = Offset(details.localPosition.dx, sliderPostion.dy);
    }
    markNeedsPaint();
  }

  _onEnd(DragEndDetails details) {}

  _onUpdate(DragUpdateDetails details) {
    if (checkPostion(details.localPosition)) {
      _location = Offset(details.localPosition.dx, sliderPostion.dy);
      _value = getPercentage(details.localPosition.dx);

    }

    markNeedsPaint();
  }

  late double _value = .5;

  Offset get sliderPostion => Offset(size.width / 1.5, size.height / 1.5);

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.drawColor(Color.lerp(Colors.pinkAccent, Colors.greenAccent, _value)!,
        BlendMode.src);

    canvas.drawLine(
        Offset(0 + 20, size.height / 1.5),
        Offset(size.width - 20, size.height / 1.5),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2);
    drawKnob(canvas);
    drawSmile(canvas);
    super.paint(context, offset);
  }

  Offset get center => Offset(size.width / 2, size.height / 2);

  Offset get eyeslocation => Offset(size.width / 2, size.height / 3.5);

  void drawKnob(Canvas canvas) {
    canvas.drawRect(Rect.fromCenter(center: _location, width: 40, height: 40),
        Paint()..color = Colors.black);

    var path = Path()
      ..moveTo(_location.dx - 10, _location.dy)
      ..lineTo(_location.dx + 10, _location.dy)
      ..lineTo(_location.dx + 5, _location.dy - 5)
      ..moveTo(_location.dx + 10, _location.dy)
      ..lineTo(_location.dx + 5, _location.dy + 5);
    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke);
  }

  double getPercentage(double postion) {
    double start = 20;
    double end = size.width - 20;
    final differance = end - start;

    return (postion - start) / differance;
  }

  Offset get firstEyeLocation => Offset(eyeslocation.dx - 100, eyeslocation.dy);
  Offset get secondEyeLocation =>
      Offset(eyeslocation.dx + 100, eyeslocation.dy);
  void drawSmile(Canvas canvas) {
    final endPoints = Offset(size.width - 20, center.dy);
    final _smile = Path()
      ..moveTo(0 + 20, center.dy)
      ..quadraticBezierTo(size.width / 2, size.height / (2.5 - (_value)),
          endPoints.dx, endPoints.dy);

    final _eye1 = Path()
      ..addArc(
          Rect.fromCenter(center: firstEyeLocation, width: 70, height: 100),
          vc.radians(0),
          vc.radians(180))
      ..cubicTo(
          firstEyeLocation.dx - 35,
          (size.height / (3.8 + _value)),
          firstEyeLocation.dx + 35,
          size.height / (3.8 + _value),
          firstEyeLocation.dx + 35,
          eyeslocation.dy);

    final _eye2 = Path()
      ..addArc(
          Rect.fromCenter(center: secondEyeLocation, width: 70, height: 100),
          vc.radians(0),
          vc.radians(180))
      ..cubicTo(
          secondEyeLocation.dx - 35,
          size.height / (3.8 + _value),
          secondEyeLocation.dx + 35,
          size.height / (3.8 + _value),
          secondEyeLocation.dx + 35,
          eyeslocation.dy);

    canvas.drawPath(
        _smile,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.black);

    canvas.drawPath(
        _eye1,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);
    canvas.drawPath(
        _eye2,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);

    canvas.drawCircle(Offset(firstEyeLocation.dx, firstEyeLocation.dy + 20), 10,
        Paint()..color = Colors.black);
    canvas.drawCircle(Offset(secondEyeLocation.dx, secondEyeLocation.dy + 20),
        10, Paint()..color = Colors.black);
  }

  @override
  handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      drag.addPointer(event);
    }
  }
}
