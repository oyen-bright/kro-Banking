import 'package:flutter/material.dart';

extension ResponsivePadding on BuildContext {
  double dynamicPadding(double basePadding) {
    double screenWidth = MediaQuery.of(this).size.width;

    const double maxWidth = 1200.0;

    double scaleFactor = screenWidth / maxWidth;

    double dynamicPadding = basePadding * scaleFactor;

    return dynamicPadding.clamp(2.0, basePadding);
  }
}
