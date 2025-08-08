import 'package:bip39_mnemonic/bip39_mnemonic.dart';

import '../../shared.dart';

class SecretPhraseUtils {
  SecretPhraseUtils._();

  static Mnemonic generate() {
    return Mnemonic.generate(
      Language.english,
      length: MnemonicLength.words12,
    );
  }

  static bool areSelectedWordsValid(
    List<WordTuple> selectedWords,
    List<WordTuple> randomIndexes,
  ) {
    final hasCorrectLength =
        selectedWords.length == UiConstants.wordsToVerify &&
            randomIndexes.length == UiConstants.wordsToVerify;

    if (!hasCorrectLength) {
      return false;
    }

    for (int i = 0; i < UiConstants.wordsToVerify; i++) {
      final selectedWord = selectedWords[i];
      final randomWord = randomIndexes[i];

      if (!selectedWord.isEquivalent(randomWord)) {
        return false;
      }
    }

    return true;
  }
}
