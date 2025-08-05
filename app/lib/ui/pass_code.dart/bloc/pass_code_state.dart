import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'pass_code_state.freezed.dart';

@freezed
class PassCodeState extends BaseBlocState with _$PassCodeState {
  const factory PassCodeState({
    @Default('') String passCode,
    @Default(false) bool shouldClearPin,
  }) = _PassCodeState;
}
