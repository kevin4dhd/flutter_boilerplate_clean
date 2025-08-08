import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

class WordsViewer extends StatelessWidget {
  const WordsViewer({
    required this.words,
    required this.selectedWords,
    required this.onTapWord,
    super.key,
  });

  final List<WordTuple> words;
  final List<WordTuple>? selectedWords;
  final void Function(WordTuple)? onTapWord;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: UiConstants.commonPS,
      runSpacing: UiConstants.commonPS,
      children: words.map(
        (x) {
          return GestureDetector(
            onTap: () => onTapWord?.call(x),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: selectedWords?.any((y) => y.index == x.index) == true
                    ? Colors.white12
                    : null,
                border: Border.all(
                  color: AppColors.current.labelColorPrimaryShade,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                x.word,
                textAlign: TextAlign.center,
                style: AppTextStyles.s16w500Primary(
                  fontFamily: FontFamily.poppins,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
