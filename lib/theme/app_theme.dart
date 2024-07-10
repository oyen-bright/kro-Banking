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
      primaryColor: AppColors.color136BFC,
      inputDecorationTheme: baseTheme.inputDecorationTheme
          .copyWith(fillColor: const Color(0xFFD2E3FC).withOpacity(0.5)),
      scaffoldBackgroundColor: AppColors.color249250250,
      textTheme: GoogleFonts.nunitoTextTheme(baseTheme.textTheme),
    );
  }
}
