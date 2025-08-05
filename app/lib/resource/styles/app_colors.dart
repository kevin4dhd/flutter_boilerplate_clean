// ignore_for_file: avoid_hard_coded_colors
import 'package:flutter/material.dart';

import '../../app.dart';

class AppColors {
  const AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.terciaryColor,
    required this.iconsColor,
    required this.popularColor,
    required this.pinBorderColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.primaryGradient,
  });

  static late AppColors current;

  final Color primaryColor;
  final Color secondaryColor;
  final Color terciaryColor;
  final Color iconsColor;
  final Color popularColor;
  final Color pinBorderColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  Color get terciaryColor25 => terciaryColor.withValues(alpha: 0.25);

  Color get iconsColor40 => iconsColor.withValues(alpha: 0.40);

  /// gradient
  final LinearGradient primaryGradient;

  static const defaultAppColor = AppColors(
    primaryColor: Color(0xFF1B0036),
    secondaryColor: Color(0xFF005B65),
    terciaryColor: Color(0xFF43388A),
    iconsColor: Color(0xFFACD9CF),
    popularColor: Color(0xFFC6C4C4),
    pinBorderColor: Color(0xFF5B6774),
    primaryTextColor: Colors.white,
    secondaryTextColor: Colors.black,
    primaryGradient:
        LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFE6C30)]),
  );

  static const darkThemeColor = AppColors(
    primaryColor: Color(0xFF1B0036),
    secondaryColor: Color(0xFF005B65),
    terciaryColor: Color(0xFF43388A),
    iconsColor: Color(0xFFACD9CF),
    popularColor: Color(0xFFC6C4C4),
    pinBorderColor: Color(0xFF5B6774),
    primaryTextColor: Colors.white,
    secondaryTextColor: Colors.black,
    primaryGradient:
        LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFE6C30)]),
  );

  static AppColors of(BuildContext context) {
    final appColor = Theme.of(context).appColor;

    current = appColor;

    return current;
  }

  AppColors copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? terciaryColor,
    Color? iconsColor,
    Color? popularColor,
    Color? pinBorderColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? terciaryTextColor,
    LinearGradient? primaryGradient,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      terciaryColor: terciaryColor ?? this.terciaryColor,
      iconsColor: iconsColor ?? this.iconsColor,
      popularColor: popularColor ?? this.popularColor,
      pinBorderColor: pinBorderColor ?? this.pinBorderColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }
}
