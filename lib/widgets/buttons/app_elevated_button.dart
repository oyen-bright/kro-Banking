import 'package:flutter/material.dart';
import 'package:kro_banking/extentions/on_context.dart';

class AppElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const AppElevatedButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.primary,
          foregroundColor: context.colorScheme.onPrimary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          minimumSize: const Size.fromHeight(kToolbarHeight)),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
