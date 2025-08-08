import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';

class WordViewer extends StatelessWidget {
  const WordViewer({
    required this.index,
    required this.randomIndexes,
    required this.selectedWords,
    this.flex = 1,
    super.key,
  });

  final int index;
  final List<WordTuple> randomIndexes;
  final List<WordTuple> selectedWords;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.current.labelColorPrimaryShade,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(UiConstants.commonRAS),
        ),
        child: Text(
          '${randomIndexes[index].index + 1}. ${_getWord(index, selectedWords)}',
          style: AppTextStyles.s16w500Shade(
            fontFamily: FontFamily.ntr,
          ),
        ),
      ),
    );
  }

  String _getWord(
    int index,
    List<WordTuple> selectedWords,
  ) {
    return index >= 0 && index < selectedWords.length
        ? selectedWords[index].word
        : '';
  }
}
