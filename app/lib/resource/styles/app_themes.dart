import 'package:flutter/material.dart';

import '../../app.dart';

/// define custom themes here
final lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.defaultAppColor.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.defaultAppColor.primaryColor,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
)..addAppColor(
    AppThemeType.light,
    AppColors.defaultAppColor,
  );

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.darkThemeColor.primaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkThemeColor.primaryColor,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
)..addAppColor(
    AppThemeType.dark,
    AppColors.darkThemeColor,
  );

enum AppThemeType { light, dark }

extension ThemeDataExtensions on ThemeData {
  static final Map<AppThemeType, AppColors> _appColorMap = {};

  void addAppColor(AppThemeType type, AppColors appColor) {
    _appColorMap[type] = appColor;
  }

  AppColors get appColor {
    return _appColorMap[AppThemeSetting.currentAppThemeType] ??
        AppColors.defaultAppColor;
  }
}

class AppThemeSetting {
  const AppThemeSetting._();
  static late AppThemeType currentAppThemeType = AppThemeType.light;
}
