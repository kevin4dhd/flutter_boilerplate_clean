import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

class Button extends StatelessWidget {
  const Button({
    required this.onTap,
    required this.width,
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  final VoidCallback? onTap;
  final double width;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(
          horizontal: UiConstants.commonP,
          vertical: UiConstants.commonPA,
        ),
        decoration: BoxDecoration(
          color: AppColors.current.terciaryColor25,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onTap,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  AppColors.current.iconsColor40,
                ),
              ),
              icon: Icon(icon),
              color: AppColors.current.iconsColor,
              iconSize: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.s18w400Primary(),
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    subtitle,
                    style: AppTextStyles.s14w400Primary(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
