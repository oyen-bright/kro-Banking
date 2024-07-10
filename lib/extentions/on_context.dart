import 'package:flutter/material.dart';

extension ResponsivePadding on BuildContext {
  double pWidth(double basePadding) {
    double screenWidth = MediaQuery.of(this).size.width;

    const double maxWidth = 1500.0;

    double scaleFactor = screenWidth / maxWidth;

    double dynamicPadding = basePadding * scaleFactor;

    return dynamicPadding.clamp(2.0, basePadding);
  }

  double pHeight(double basePadding) {
    double screenHeight = MediaQuery.of(this).size.height;
    const double maxHeight = 800.0;
    double scaleFactor = screenHeight / maxHeight;
    double dynamicPadding = basePadding * scaleFactor;
    return dynamicPadding.clamp(2.0, basePadding);
  }

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  dynamic get focus => FocusScope.of(this).nextFocus();
  dynamic get removeFocus => FocusScope.of(this).unfocus();
}
