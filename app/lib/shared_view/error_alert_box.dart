import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class ErrorAlertBox extends StatelessWidget {
  const ErrorAlertBox({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 60),
      padding: EdgeInsets.symmetric(vertical: UiConstants.commonPSS),
      child: text.isNotEmpty
          ? Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UiConstants.commonRS),
                  color: AppColors.current.alertLigthColor25,
                ),
                padding: const EdgeInsets.all(UiConstants.commonPS),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error,
                      color: AppColors.current.alertLigthColor,
                    ),
                    const SizedBox(width: UiConstants.commonPS),
                    Flexible(
                      child: Text(
                        text,
                        style: AppTextStyles.s14w400Alert(
                          fontFamily: FontFamily.opensans,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
