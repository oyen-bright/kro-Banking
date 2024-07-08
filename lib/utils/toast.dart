import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/widgets/overlay/toast_overlay.dart';

class Toasts {
  static void showSuccess(String message, BuildContext context) {
    _show(message, context.colorScheme.primary, context);
  }

  static void showError(String message, BuildContext context) {
    _show(message, Colors.red, context);
  }

  static void _show(
    String message,
    Color backgroundColor,
    BuildContext context,
  ) {
    print("called");
    final overlayState = Overlay.of(context, rootOverlay: true);

    final overlayEntry = OverlayEntry(
      builder: (context) => ToastsOverlay(
        message: message,
        backgroundColor: backgroundColor,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      overlayState.insert(overlayEntry);
      Future.delayed(4.seconds, overlayEntry.remove);
    });
  }
}
