import 'dart:async';
import 'package:flutter/material.dart';

class FadeSlideDelayHelper extends StatefulWidget {
  final Widget child;
  final int? delay;
  final String? direction;
  final double? length;
  final int? duration;

  const FadeSlideDelayHelper({
    Key? key,
    required this.child,
    this.delay,
    this.direction,
    this.length,
    this.duration,
  }) : super(key: key);

  @override
  State<FadeSlideDelayHelper> createState() => _FadeSlideDelayHelperState();
}

class _FadeSlideDelayHelperState extends State<FadeSlideDelayHelper> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animOffset;

  double? _dataLength;
  Offset? _dataOffset;

  @override
  void initState() {
    super.initState();

    _dataLength = widget.length ?? 0.05;
    _dataOffset = Offset(0.0, _dataLength!);

    if (widget.direction == 'top') {
      _dataOffset = Offset(0.0, _dataLength! * -1);
    } else if (widget.direction == 'left') {
      _dataOffset = Offset(_dataLength! * -1, 0.0);
    } else if (widget.direction == 'right') {
      _dataOffset = Offset(_dataLength!, 0.0);
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration ?? 800),
    );
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _controller!);
    _animOffset = Tween<Offset>(begin: _dataOffset, end: Offset.zero).animate(curve);

    if (widget.delay == null) {
      _controller!.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay ?? 0), () {
        _controller!.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller!,
      child: SlideTransition(
        position: _animOffset!,
        child: widget.child,
      ),
    );
  }
}
