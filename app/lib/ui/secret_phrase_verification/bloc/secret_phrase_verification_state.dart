import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'secret_phrase_verification_state.freezed.dart';

@freezed
class SecretPhraseVerificationState extends BaseBlocState
    with _$SecretPhraseVerificationState {
  const factory SecretPhraseVerificationState({
    @Default(<WordTuple>[]) List<WordTuple> shuffledWords,
    @Default(<WordTuple>[]) List<WordTuple> selectedWords,
    @Default(<WordTuple>[]) List<WordTuple> randomIndexes,
    @Default('') String verificationError,
    @Default(true) bool isLoading,
    @Default(false) bool isProcessing,
  }) = _SecretPhraseVerificationState;
}
