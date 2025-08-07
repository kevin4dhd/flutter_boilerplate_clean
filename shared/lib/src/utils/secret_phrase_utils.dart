import 'package:bip39_mnemonic/bip39_mnemonic.dart';

class SecretPhraseUtils {
  SecretPhraseUtils._();

  static Mnemonic generate() {
    return Mnemonic.generate(
      Language.english,
      length: MnemonicLength.words12,
    );
  }
}
