import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration period;
  final bool? enabled;

  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.enabled,
    this.highlightColor,
    this.period = const Duration(milliseconds: 1500),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: enabled ?? true,
      baseColor: baseColor ?? Colors.grey[200]!,
      highlightColor: highlightColor ?? Colors.grey[50]!,
      period: period,
      child: child,
    );
  }
}
