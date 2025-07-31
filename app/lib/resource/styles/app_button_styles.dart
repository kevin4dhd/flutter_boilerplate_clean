import 'package:flutter/material.dart';

import '../../app.dart';

class AppButtonStyles {
  AppButtonStyles._();

  static final basicButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.current.secondaryColor,
    foregroundColor: AppColors.current.iconsColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: const TextStyle(fontSize: 22),
  );
}
