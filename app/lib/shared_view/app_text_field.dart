import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.title = '',
    this.hintText = '',
    this.errorText,
    this.controller,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.inputFormatter,
    this.enabled = false,
    this.error = false,
    this.autofocus = false,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.showCounter = false,
    this.onChanged,
    this.onTap,
    this.suffix,
    super.key,
  });

  final String title;
  final String hintText;
  final String? errorText;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final int maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputFormatter? inputFormatter;
  final bool enabled;
  final bool error;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool showCounter;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: enabled
                    ? AppTextStyles.s18w500Popular()
                    : AppTextStyles.s18w500Popular75(),
              ),
            ),
            if (suffix != null) ...[
              SizedBox(width: 10),
              suffix!,
            ],
          ],
        ),
        SizedBox(height: Dimens.d5.responsive()),
        InputContainer(
          enabled: enabled,
          child: TextField(
            enabled: enabled,
            autofocus: autofocus,
            autocorrect: autocorrect,
            enableSuggestions: enableSuggestions,
            controller: controller,
            onTap: onTap,
            onChanged: onChanged,
            maxLines: maxLines,
            maxLength: maxLength,
            textAlign: textAlign,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            textInputAction: textInputAction,
            inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
            style: TextStyle(
              color: enabled
                  ? AppColors.current.iconsColor
                  : AppColors.current.iconsColor50,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.current.iconsColor50,
              ),
              errorText: error ? errorText : null,
              counterText: showCounter ? null : '',
              border: InputBorder.none,
              enabledBorder: error
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.current.alertLigthColor,
                      ),
                    )
                  : null,
              focusedBorder: error
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.current.alertLigthColor,
                        width: 2,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
