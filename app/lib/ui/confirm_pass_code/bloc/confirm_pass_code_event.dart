import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'confirm_pass_code_event.freezed.dart';

abstract class ConfirmPassCodeEvent extends BaseBlocEvent {
  const ConfirmPassCodeEvent();
}

@freezed
class ConfirmPassCodePinChanged extends ConfirmPassCodeEvent
    with _$ConfirmPassCodePinChanged {
  const factory ConfirmPassCodePinChanged({
    required String confirmPassCode,
  }) = _ConfirmPassCodePinChanged;
}

@freezed
class ConfirmPassCodePinCompleted extends ConfirmPassCodeEvent
    with _$ConfirmPassCodePinCompleted {
  const factory ConfirmPassCodePinCompleted({
    required String confirmPassCode,
    required String passCode,
  }) = _ConfirmPassCodePinCompleted;
}

@freezed
class ConfirmPassCodePinClear extends ConfirmPassCodeEvent
    with _$ConfirmPassCodePinClear {
  const factory ConfirmPassCodePinClear() = _ConfirmPassCodePinClear;
}

@freezed
class EnableBiometric extends ConfirmPassCodeEvent with _$EnableBiometric {
  const factory EnableBiometric({
    required bool enabledBiometric,
  }) = _EnableBiometric;
}
