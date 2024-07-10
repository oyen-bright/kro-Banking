import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kro_banking/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    // return ThemeData();

    var baseTheme = ThemeData(brightness: Brightness.light);

    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: AppColors.color136BFC,
      ),
      scaffoldBackgroundColor: AppColors.color249250250,
      textTheme: GoogleFonts.nunitoTextTheme(baseTheme.textTheme),
    );
  }
}
