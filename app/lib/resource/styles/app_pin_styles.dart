import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

class AppPinStyles {
  AppPinStyles._();

  static PinTheme getDefaultTheme() => PinTheme(
        width: 46,
        height: 44,
        textStyle: TextStyle(
          fontSize: 22,
          color: AppColors.current.primaryTextColor,
        ),
        decoration: BoxDecoration(
          color: AppColors.current.terciaryColor25,
          borderRadius: BorderRadius.circular(UiConstants.commonRS),
          border: Border.all(color: AppColors.current.pinBorderColor),
        ),
      );
}
