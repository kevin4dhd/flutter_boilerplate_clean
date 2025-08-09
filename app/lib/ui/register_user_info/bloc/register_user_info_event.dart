import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'register_user_info_event.freezed.dart';

abstract class RegisterUserInfoEvent extends BaseBlocEvent {
  const RegisterUserInfoEvent();
}

@freezed
class TapOnContinue extends RegisterUserInfoEvent with _$TapOnContinue {
  const factory TapOnContinue() = _TapOnContinue;
}
