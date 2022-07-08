import 'dart:async';

import 'package:flutter/material.dart';

class ZoomInDelayHelper extends StatefulWidget {
  final Widget child;
  final int? delay;
  final double? length;
  final int? duration;
  final Curve? curve;

  const ZoomInDelayHelper({
    Key? key,
    required this.child,
    this.delay,
    this.length,
    this.duration = 1000,
    this.curve = Curves.bounceOut,
  }) : super(key: key);

  @override
  State<ZoomInDelayHelper> createState() => _ZoomInDelayHelperState();
}

class _ZoomInDelayHelperState extends State<ZoomInDelayHelper> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: widget.duration!),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: widget.curve!,
  );

  @override
  void initState() {
    super.initState();
    if (widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay ?? 0), () {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
