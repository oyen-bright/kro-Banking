import 'package:flutter/material.dart';

class ScrollControllerProvider extends InheritedWidget {
  final ScrollController scrollController;

  const ScrollControllerProvider({
    required this.scrollController,
    required super.child,
    super.key,
  });

  static ScrollControllerProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ScrollControllerProvider>();
  }

  @override
  bool updateShouldNotify(ScrollControllerProvider oldWidget) {
    return scrollController != oldWidget.scrollController;
  }
}
