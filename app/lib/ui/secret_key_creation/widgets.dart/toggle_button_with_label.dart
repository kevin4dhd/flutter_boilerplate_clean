import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

class ToggleButtonWithLabel extends StatelessWidget {
  const ToggleButtonWithLabel({
    required this.label,
    required this.style,
    required this.value,
    this.onChanged,
    super.key,
  });

  final String label;
  final TextStyle style;
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    final appColors = AppColors.current;
    final primaryButtonColor = appColors.primaryButtonColor;
    return Row(
      children: [
        Container(
          height: UiConstants.iconSize,
          width: UiConstants.iconSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value ? primaryButtonColor : Colors.transparent,
          ),
          child: Checkbox(
            shape: const CircleBorder(eccentricity: 1),
            activeColor: primaryButtonColor,
            checkColor: appColors.primaryTextColor,
            value: value,
            onChanged: (value) => onChanged?.call(value ?? false),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: style,
          ),
        ),
      ],
    );
  }
}
