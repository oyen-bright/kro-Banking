import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kro_banking/extentions/on_context.dart';

class SlowLinearProgressIndicator extends StatefulWidget {
  final Duration duration;
  final bool isEnabled;

  const SlowLinearProgressIndicator({
    super.key,
    required this.duration,
    this.isEnabled = true,
  });

  @override
  SlowLinearProgressIndicatorState createState() =>
      SlowLinearProgressIndicatorState();
}

class SlowLinearProgressIndicatorState
    extends State<SlowLinearProgressIndicator> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void resetProgress() {
    setState(() {
      _progress = 0.0;
    });
  }

  void startTimer() {
    resetProgress();
    _timer = Timer.periodic(
      Duration(milliseconds: widget.duration.inMilliseconds ~/ 100),
      (_) {
        if (mounted) {
          setState(() {
            if (_progress >= 0.8) {
              _progress += 0.001;
              if (_progress >= 0.99) {
                _progress = 0.99;
                _timer?.cancel();
              }
            } else {
              _progress += 0.01;
            }
          });
        }
      },
    );
  }

  @override
  void didUpdateWidget(covariant SlowLinearProgressIndicator oldWidget) {
    if (widget.isEnabled && !oldWidget.isEnabled) {
      startTimer();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: widget.isEnabled ? _progress : 0,
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
    );
  }
}
