import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef ClickableTextTuple = ({String text, int index});

class TextParserUtils {
  TextParserUtils._();

  static List<ClickableTextTuple> parseClickableText(String text) {
    final tuples = <ClickableTextTuple>[];
    int pivot = 0;

    while (true) {
      final sText = text.substring(pivot);
      final fIndex = sText.indexOf('{');

      if (fIndex == -1) {
        if (sText.isNotEmpty) {
          tuples.add((text: sText, index: 0));
        }
        break;
      }

      if (fIndex > 0) {
        tuples.add((
          text: sText.substring(0, fIndex),
          index: 0,
        ));
      }

      final lIndex = sText.indexOf('}');
      if (lIndex == -1) {
        break; // Malformed text, stop parsing
      }

      final innerText = sText.substring(fIndex + 1, lIndex);
      final parts = innerText.split(',');
      if (parts.length != 2) {
        pivot += lIndex + 1;
        tuples.add((text: '{$innerText}', index: 0));
        continue; // Skip malformed links
      }

      String content;
      int? index = int.tryParse(parts.first.trim());
      if (index == null) {
        index = int.tryParse(parts.last.trim());
        content = parts.first.trim();
      } else {
        content = parts.last.trim();
      }

      if (index != null && content.isNotEmpty) {
        tuples.add(
          (
            text: content,
            index: index,
          ),
        );
      } else {
        tuples.add(
          (
            text: '{$innerText}',
            index: 0,
          ),
        );
      }

      pivot += lIndex + 1;
    }

    return tuples;
  }

  /// Parses text with clickable links in format: {id,text} or {text,id}
  /// Example: "Accept {1,Terms} and {2,Privacy}"
  /// Returns list of TextSpan with clickable elements
  static List<TextSpan> generateSpanList({
    required String text,
    required Function(int linkId) onLinkTap,
    TextStyle? defaultStyle,
    TextStyle? linkStyle,
  }) {
    return parseClickableText(text).map((x) {
      if (x.index > 0) {
        return TextSpan(
          text: x.text,
          style: linkStyle ?? defaultStyle,
        );
      } else {
        return TextSpan(
          text: x.text,
          style: defaultStyle,
          recognizer: TapGestureRecognizer()..onTap = () => onLinkTap(x.index),
        );
      }
    }).toList();
  }
}
