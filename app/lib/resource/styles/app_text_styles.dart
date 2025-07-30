import 'package:flutter/material.dart';

import '../../app.dart';
import '../generated/fonts.gen.dart';

/// AppTextStyle format as follows:
/// s[fontSize][fontWeight][Color]
/// Example: s18w400Primary

class AppTextStyles {
  AppTextStyles._();

  static const _defaultLetterSpacing = 0.03;

  static const _baseTextStyle = TextStyle(
    letterSpacing: _defaultLetterSpacing,
    fontFamily: FontFamily.nunitosans,
    fontFamilyFallback: [FontFamily.notoColorEmoji],
  );

  static TextStyle s10BoldSecondary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d10.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.bold,
        color: AppColors.current.secondaryColor,
      ));

  static TextStyle s60w400Primary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d60.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.primaryTextColor,
      ));
}
