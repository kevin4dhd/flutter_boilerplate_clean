import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'pass_code_event.freezed.dart';

abstract class PassCodeEvent extends BaseBlocEvent {
  const PassCodeEvent();
}

@freezed
class PassCodePinChanged extends PassCodeEvent with _$PassCodePinChanged {
  const factory PassCodePinChanged({
    required String passCode,
  }) = _PassCodePinChanged;
}

@freezed
class PassCodePinCompleted extends PassCodeEvent with _$PassCodePinCompleted {
  const factory PassCodePinCompleted({
    required String passCode,
  }) = _PassCodePinCompleted;
}

@freezed
class PassCodePinClear extends PassCodeEvent with _$PassCodePinClear {
  const factory PassCodePinClear() = _PassCodePinClear;
}
