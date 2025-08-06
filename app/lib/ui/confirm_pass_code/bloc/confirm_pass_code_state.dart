import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'confirm_pass_code_state.freezed.dart';

@freezed
class ConfirmPassCodeState extends BaseBlocState with _$ConfirmPassCodeState {
  const factory ConfirmPassCodeState({
    @Default('') String confirmPassCode,
    @Default(false) bool shouldClearPin,
    @Default(false) bool enabledBiometric,
  }) = _ConfirmPassCodeState;
}
