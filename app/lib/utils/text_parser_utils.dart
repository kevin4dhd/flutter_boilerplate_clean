import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextParserUtils {
  TextParserUtils._();

  /// Parses text with clickable links in format: {id,text} or {text,id}
  /// Example: "Accept {1,Terms} and {2,Privacy}"
  /// Returns list of TextSpan with clickable elements
  static List<TextSpan> parseClickableText({
    required String text,
    required Function(int linkId, String linkText) onLinkTap,
    TextStyle? defaultStyle,
    TextStyle? linkStyle,
  }) {
    final spans = <TextSpan>[];
    int pivot = 0;

    while (true) {
      final sText = text.substring(pivot);
      final fIndex = sText.indexOf('{');

      if (fIndex == -1) {
        if (sText.isNotEmpty) {
          spans.add(TextSpan(text: sText, style: defaultStyle));
        }
        break;
      }

      if (fIndex > 0) {
        spans.add(TextSpan(
          text: sText.substring(0, fIndex),
          style: defaultStyle,
        ));
      }

      final lIndex = sText.indexOf('}');
      if (lIndex == -1) {
        break; // Malformed text, stop parsing
      }

      final parts = sText.substring(fIndex + 1, lIndex).split(',');
      if (parts.length != 2) {
        pivot += lIndex + 1;
        continue; // Skip malformed links
      }

      String content;
      int? linkId = int.tryParse(parts.first.trim());
      if (linkId == null) {
        linkId = int.tryParse(parts.last.trim());
        content = parts.first.trim();
      } else {
        content = parts.last.trim();
      }

      if (linkId != null && content.isNotEmpty) {
        spans.add(
          TextSpan(
            text: content,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => onLinkTap(linkId!, content),
          ),
        );
      }

      pivot += lIndex + 1;
    }

    return spans;
  }
}
