import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UiConstants {
  const UiConstants._();

  /// shimmer
  static const shimmerItemCount = 20;

  /// material app
  static const materialAppTitle = 'My App';
// ignore: avoid_hard_coded_colors
  static const taskMenuMaterialAppColor = Color.fromARGB(255, 153, 154, 251);

  /// orientation
  static const mobileOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  static const tabletOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  /// status bar color
  static const systemUiOverlay = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  );

  static const textFieldTextStyleHeight = 1.3;

  static const commonPB = 32.0;
  static const commonP = 16.0;
  static const commonPA = 12.0;
  static const commonPS = 8.0;
  static const commonPSS = 4.0;

  static const commonR = 10.0;
  static const commonRS = 5.0;
  static const commonRL = 20.0;

  static const commonRA = 8.0;
  static const commonRAS = 4.0;
  static const commonRAL = 16.0;

  static const iconSizeS = 20.0;
  static const iconSize = 30.0;
  static const iconSizeL = 40.0;

  static const defaultPinLength = 6;
}
