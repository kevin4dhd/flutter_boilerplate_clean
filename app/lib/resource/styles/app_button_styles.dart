import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

class AppButtonStyles {
  AppButtonStyles._();

  static ButtonStyle getBasicStyle() => ElevatedButton.styleFrom(
        backgroundColor: AppColors.current.secondaryColor,
        foregroundColor: AppColors.current.iconsColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 20),
      );

  static ButtonStyle getAppBarButtonStyle() => ElevatedButton.styleFrom(
        backgroundColor: AppColors.current.appBarButtonBGColor,
        foregroundColor: AppColors.current.iconsColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiConstants.commonRA),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        textStyle: AppTextStyles.s18w500Icons(),
      );
}
