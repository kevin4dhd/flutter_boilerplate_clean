import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    required this.child,
    this.enabled = false,
    this.padding = const EdgeInsets.symmetric(horizontal: UiConstants.commonR),
    this.constraints,
    super.key,
  });

  final bool enabled;
  final EdgeInsetsGeometry padding;
  final BoxConstraints? constraints;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimen.current.screenWidth,
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        color: enabled
            ? AppColors.current.terciaryColor25
            : AppColors.current.terciaryColor10,
        borderRadius: BorderRadius.circular(UiConstants.commonR),
      ),
      child: child,
    );
  }
}
