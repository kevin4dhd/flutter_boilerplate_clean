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
    required this.fingerprintBGColor,
    required this.backButtonColor,
    required this.appBarButtonBGColor,
    required this.primaryButtonColor,
    required this.labelColorPrimaryShade,
    required this.alertLigthColor,
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
  final Color fingerprintBGColor;
  final Color backButtonColor;
  final Color appBarButtonBGColor;
  final Color primaryButtonColor;
  final Color labelColorPrimaryShade;
  final Color alertLigthColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  Color get primaryColor50 => terciaryColor.withValues(alpha: 0.50);

  Color get terciaryColor10 => terciaryColor.withValues(alpha: 0.10);

  Color get terciaryColor25 => terciaryColor.withValues(alpha: 0.25);

  Color get terciaryColor75 => terciaryColor.withValues(alpha: 0.75);

  Color get iconsColor40 => iconsColor.withValues(alpha: 0.40);

  Color get iconsColor50 => iconsColor.withValues(alpha: 0.50);

  Color get fingerprintBGColor55 => iconsColor.withValues(alpha: 0.55);

  Color get alertLigthColor25 => alertLigthColor.withValues(alpha: 0.25);

  Color get popularColor50 => popularColor.withValues(alpha: 0.50);

  Color get popularColor75 => popularColor.withValues(alpha: 0.75);

  /// gradient
  final LinearGradient primaryGradient;

  static const defaultAppColor = AppColors(
    primaryColor: Color(0xFF1B0036),
    secondaryColor: Color(0xFF005B65),
    terciaryColor: Color(0xFF43388A),
    iconsColor: Color(0xFFACD9CF),
    popularColor: Color(0xFFC6C4C4),
    pinBorderColor: Color(0xFF5B6774),
    fingerprintBGColor: Color(0xFF808080),
    backButtonColor: Color(0xFFADA2B9),
    appBarButtonBGColor: Color(0x4043388A),
    labelColorPrimaryShade: Color(0xFF6C7CA7),
    primaryButtonColor: Color(0xFF005865),
    alertLigthColor: Color(0xFFFA667B),
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
    fingerprintBGColor: Color(0xFF808080),
    backButtonColor: Color(0xFFADA2B9),
    appBarButtonBGColor: Color(0x4043388A),
    primaryButtonColor: Color(0xFF005865),
    labelColorPrimaryShade: Color(0xFF6C7CA7),
    alertLigthColor: Color(0xFFFA667B),
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
    Color? fingerprintBGColor,
    Color? backButtonColor,
    Color? appBarButtonBGColor,
    Color? primaryButtonColor,
    Color? labelColorPrimaryShade,
    Color? primaryTextColor,
    Color? alertLigthColor,
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
      fingerprintBGColor: fingerprintBGColor ?? this.fingerprintBGColor,
      backButtonColor: backButtonColor ?? this.backButtonColor,
      appBarButtonBGColor: appBarButtonBGColor ?? this.appBarButtonBGColor,
      primaryButtonColor: primaryButtonColor ?? this.primaryButtonColor,
      labelColorPrimaryShade:
          labelColorPrimaryShade ?? this.labelColorPrimaryShade,
      alertLigthColor: alertLigthColor ?? this.alertLigthColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }
}
