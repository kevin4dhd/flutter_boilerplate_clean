import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'secret_phrase_creation_event.freezed.dart';

abstract class SecretPhraseCreationEvent extends BaseBlocEvent {
  const SecretPhraseCreationEvent();
}

@freezed
class GenerateSecretPhrase extends SecretPhraseCreationEvent
    with _$GenerateSecretPhrase {
  const factory GenerateSecretPhrase() = _GenerateSecretPhrase;
}

@freezed
class SetCheck1 extends SecretPhraseCreationEvent with _$SetCheck1 {
  const factory SetCheck1({
    required bool isCheck1,
  }) = _SetCheck1;
}

@freezed
class SetCheck2 extends SecretPhraseCreationEvent with _$SetCheck2 {
  const factory SetCheck2({
    required bool isCheck2,
  }) = _SetCheck2;
}

@freezed
class TapOnContinue extends SecretPhraseCreationEvent with _$TapOnContinue {
  const factory TapOnContinue() = _TapOnContinue;
}
