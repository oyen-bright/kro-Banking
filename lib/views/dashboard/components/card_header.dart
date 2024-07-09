import 'package:flutter/material.dart';
import 'package:kro_banking/extentions/on_context.dart';

class CardHeader extends StatelessWidget {
  const CardHeader(
      {super.key,
      this.onPressed,
      required this.title,
      required this.buttonTitle});
  final void Function()? onPressed;
  final String title;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: context.textTheme.titleMedium!.fontSize! + 2),
        ),
        const Spacer(),
        TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}
