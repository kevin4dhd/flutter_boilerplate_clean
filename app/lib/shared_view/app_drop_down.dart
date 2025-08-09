import 'package:flutter/material.dart';

import '../app.dart';

class AppDropDown<T, V> extends StatelessWidget {
  const AppDropDown({
    required this.enabled,
    required this.title,
    required this.hintText,
    required this.value,
    required this.items,
    required this.itemBuilder,
    required this.onChanged,
    this.compare,
    this.onTap,
    super.key,
  });

  final bool enabled;
  final String title;
  final String hintText;
  final V? value;
  final List<T> items;
  final DropdownMenuItem<V> Function(T, bool) itemBuilder;
  final ValueChanged<V?>? onChanged;
  final VoidCallback? onTap;
  final bool Function(T, V?)? compare;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: enabled
              ? AppTextStyles.s18w500Popular()
              : AppTextStyles.s18w500Popular75(),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: onTap,
          child: InputContainer(
            enabled: enabled,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<V>(
                dropdownColor: AppColors.current.terciaryColor,
                isExpanded: true,
                style: TextStyle(
                  color: enabled
                      ? AppColors.current.iconsColor
                      : AppColors.current.iconsColor50,
                ),
                hint: Text(
                  hintText,
                  style: TextStyle(
                    color: AppColors.current.iconsColor50,
                  ),
                ),
                value: value,
                items: items
                    .map((x) => itemBuilder(
                          x,
                          value != null &&
                              (compare?.call(x, value) ?? value == x),
                        ))
                    .toList(),
                onChanged: enabled ? onChanged : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
