import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class ToastsOverlay extends StatefulWidget {
  const ToastsOverlay({
    required this.message,
    required this.backgroundColor,
    super.key,
  });

  final String message;
  final Color backgroundColor;

  @override
  State<ToastsOverlay> createState() => _ToastsOverlayState();
}

class _ToastsOverlayState extends State<ToastsOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Positioned(
        top: sy(40),
        left: sx(20),
        right: sx(20),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: sx(20),
              vertical: sy(5),
            ),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: sy(8),
                  ),
                ),
                SizedBox(
                  height: sy(5),
                ),
                LinearProgressIndicator(
                  value: _animation.value,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
