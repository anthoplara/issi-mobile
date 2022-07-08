import 'package:flutter/material.dart';

class BouncingButtonHelper extends StatefulWidget {
  final Widget child;
  final Color color;
  final bool enable;
  final double? height;
  final double width;
  final double bouncDeep;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final VoidCallback onTap;
  final bool autoWidth;
  final bool autoHeight;

  const BouncingButtonHelper({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.enable = true,
    this.height = 42,
    this.width = 220,
    this.bouncDeep = 0.05,
    this.borderRadius,
    this.boxShadow,
    this.border,
    required this.onTap,
    this.autoWidth = false,
    this.autoHeight = false,
  }) : super(key: key);

  @override
  State<BouncingButtonHelper> createState() => _BouncingButtonHelperState();
}

class _BouncingButtonHelperState extends State<BouncingButtonHelper> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: widget.bouncDeep,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return widget.enable
        ? GestureDetector(
            onTapCancel: () {
              _controller!.reverse();
            },
            onTapDown: (TapDownDetails details) {
              _controller!.forward();
            },
            onTapUp: (TapUpDetails details) {
              _controller!.reverse();
              widget.onTap();
            },
            child: Transform.scale(
              scale: _scale!,
              child: output(),
            ),
          )
        : output();
  }

  Widget output() {
    return Container(
      width: widget.autoWidth ? null : widget.width,
      height: widget.autoHeight ? null : widget.height,
      //width: widget.width,
      decoration: BoxDecoration(
        boxShadow: widget.boxShadow ??
            [
              const BoxShadow(
                color: Colors.transparent,
                blurRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
        border: widget.border ?? Border.all(width: 0.0, color: Colors.transparent),
        borderRadius: widget.borderRadius ?? BorderRadius.circular((widget.height ?? 48) / 2),
        color: widget.enable ? widget.color : widget.color.withOpacity(0.5),
      ),
      child: Center(
        child: widget.child,
      ),
    );
  }
}
