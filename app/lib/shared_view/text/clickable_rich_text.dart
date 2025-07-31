import 'package:flutter/material.dart';

import '../../app.dart';
import '../../utils/text_parser_utils.dart';

class ClickableRichText extends StatelessWidget {
  const ClickableRichText({
    required this.text,
    required this.onLinkTap,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.linkStyle,
    super.key,
  });

  final String text;
  final Function(int linkId, String linkText) onLinkTap;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: TextParserUtils.parseClickableText(
          text: text,
          onLinkTap: onLinkTap,
          defaultStyle: textStyle,
          linkStyle: linkStyle ?? TextStyle(color: AppColors.current.iconsColor),
        ),
        style: textStyle,
      ),
      textAlign: textAlign,
    );
  }
}
