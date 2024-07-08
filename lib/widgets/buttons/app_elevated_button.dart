import 'package:flutter/material.dart';

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
          shape: const RoundedRectangleBorder(),
          minimumSize: const Size.fromHeight(kToolbarHeight)),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
