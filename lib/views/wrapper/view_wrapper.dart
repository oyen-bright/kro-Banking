import 'package:flutter/material.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ViewWrapper extends StatelessWidget {
  const ViewWrapper(
      {super.key, required this.child, required this.headerTitle});
  final Widget child;
  final String headerTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 0.5.sh,
          ),
          Container(
            color: context.theme.scaffoldBackgroundColor,
            alignment: Alignment.centerLeft,
            // height: 2,
            width: double.infinity,
            child: Text(
              headerTitle,
              style: context.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 1.sh,
          ),
          child,
          SizedBox(
            height: 2.sh,
          ),
        ]);
  }
}
