import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'secret_phrase_verification_event.freezed.dart';

abstract class SecretPhraseVerificationEvent extends BaseBlocEvent {
  const SecretPhraseVerificationEvent();
}

@freezed
class PageInitiated extends SecretPhraseVerificationEvent with _$PageInitiated {
  const factory PageInitiated({
    required Mnemonic secretPhrase,
  }) = _PageInitiated;
}

@freezed
class SelectWord extends SecretPhraseVerificationEvent with _$SelectWord {
  const factory SelectWord({
    required WordTuple word,
  }) = _SelectWord;
}

@freezed
class TapOnContinue extends SecretPhraseVerificationEvent with _$TapOnContinue {
  const factory TapOnContinue({
    required SecretPhraseVerificationParams params,
  }) = _TapOnContinue;
}
