import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'secret_phrase_creation_state.freezed.dart';

@freezed
class SecretPhraseCreationState extends BaseBlocState
    with _$SecretPhraseCreationState {
  const factory SecretPhraseCreationState({
    @Default(null) Mnemonic? secretPhrase,
    @Default(false) bool isCheck1,
    @Default(false) bool isCheck2,
    @Default(false) bool isProcessing,
  }) = _SecretPhraseCreationState;
}
