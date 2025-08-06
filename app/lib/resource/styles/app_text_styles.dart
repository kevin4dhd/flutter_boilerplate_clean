import 'package:flutter/material.dart';

import '../../app.dart';

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

  static TextStyle s10w400Primary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d10.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.primaryTextColor,
      ));

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

  static TextStyle s12w400Primary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d12.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s12BoldPopular({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d12.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.bold,
        color: AppColors.current.popularColor,
      ));

  static TextStyle s12BoldIcons({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d12.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.bold,
        color: AppColors.current.iconsColor,
      ));

  static TextStyle s14w400Primary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s14w400Popular({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.popularColor,
      ));

  static TextStyle s14BoldPrimary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.bold,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s14BoldPopular({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d14.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.bold,
        color: AppColors.current.popularColor,
      ));

  static TextStyle s15w400Primary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d15.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s15w400Popular({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
    double? letterSpacing,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d15.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.popularColor,
        letterSpacing: letterSpacing,
      ));

  static TextStyle s16w400Popular({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d16.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.popularColor,
      ));

  static TextStyle s17w400Primary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d17.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s18w400Primary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d18.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.primaryTextColor,
      ));

  static TextStyle s42w400Primary({
    String? fontFamily,
    double? tablet,
    double? ultraTablet,
  }) =>
      _baseTextStyle.merge(TextStyle(
        fontFamily: fontFamily,
        fontSize:
            Dimens.d42.responsive(tablet: tablet, ultraTablet: ultraTablet),
        fontWeight: FontWeight.w400,
        color: AppColors.current.primaryTextColor,
        height: 0.78,
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
        height: 0.78,
      ));
}
