import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/material.dart';

import '../app.dart';

class SecretPhraseViewer extends StatelessWidget {
  const SecretPhraseViewer({
    required this.secretPhrase,
    super.key,
  });

  final Mnemonic secretPhrase;

  final _maxCols = 3;

  @override
  Widget build(BuildContext context) {
    final words = secretPhrase.words;
    final length = secretPhrase.length.words;
    final rows = (length / _maxCols).ceil();

    final labelColorPrimaryShade = AppColors.current.labelColorPrimaryShade;

    return Column(
      children: List<Widget>.generate(
        rows,
        (row) => Row(
          children: List<Widget>.generate(
            _maxCols,
            (col) {
              final index = _maxCols * row + col;

              return Expanded(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(5),
                  child: index < length
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: labelColorPrimaryShade,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: AppTicker(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${index + 1}.',
                                    style: TextStyle(
                                      color: labelColorPrimaryShade,
                                    ),
                                  ),
                                  TextSpan(text: ' ${words[index]}'),
                                ],
                                style: AppTextStyles.s15w500Primary(
                                  fontFamily: FontFamily.ntr,
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
