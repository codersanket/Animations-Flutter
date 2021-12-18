import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSliderWidget(ticker: this),
    );
  }
}

class CustomSliderWidget extends LeafRenderObjectWidget {
  const CustomSliderWidget({
    Key? key,
    required this.ticker,
  }) : super(key: key);
  final TickerProvider ticker;
  @override
  RenderObject createRenderObject(BuildContext context) =>
      CustomSliderRendrer(vsync: ticker);
  @override
  void updateRenderObject(
      BuildContext context, covariant CustomSliderRendrer renderObject) {
    renderObject.vsync = ticker;
  }
}

class CustomSliderRendrer extends RenderBox {
  CustomSliderRendrer({required TickerProvider vsync}) {
    dragger = PanGestureRecognizer()
      ..onStart = _onstart
      ..onEnd = _onEnd
      ..onUpdate = _onUpdate;
    _vsync = vsync;
  }

  late TickerProvider _vsync;
  late PanGestureRecognizer dragger;
  late AnimationController _animationController;

  TickerProvider get vsync => _vsync;

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
    _knobLocation = center;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.smallest;
  }

  Offset get center => Offset(size.width / 2, size.height / 2);

  Offset get knobLocation => center;
  late Offset _knobLocation;
  set knobLocation(Offset location) {
    _knobLocation = location;
  }

  void _onstart(DragStartDetails details) async {
    _animationController.value = details.localPosition.dx;
    _knobLocation = Offset.lerp(
        center, Offset(center.dx, center.dy - 60), _animationController.value)!;
  }

  set vsync(TickerProvider vsync) {
    if (vsync == _vsync) {
      return;
    }

    _vsync = vsync;
    _animationController.resync(_vsync);
  }

  void _onUpdate(DragUpdateDetails details) {}

  void _onEnd(DragEndDetails details) {
    knobLocation = center;
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _animationController = AnimationController(
        value: 0.0, vsync: _vsync, duration: const Duration(seconds: 2));

    _animationController.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    canvas.drawRect(
        Rect.fromCenter(center: center, width: size.width - 80, height: 50),
        Paint()..color = Colors.black);
    canvas.drawArc(
        Rect.fromCenter(center: Offset(40, center.dy), width: 50, height: 50),
        angleToRadian(90),
        angleToRadian(180),
        false,
        Paint()..color = Colors.black);
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.width - 40, center.dy), width: 50, height: 50),
        angleToRadian(90),
        angleToRadian(-180),
        false,
        Paint()..color = Colors.black);
    canvas.drawCircle(_knobLocation, 22, Paint()..color = Colors.blueAccent);

    super.paint(context, offset);
  }

  @override
  handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      dragger.addPointer(event);
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  angleToRadian(double angle) => angle * (pi / 180);
}
