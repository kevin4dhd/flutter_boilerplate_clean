import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'register_user_info_state.freezed.dart';

@freezed
class RegisterUserInfoState extends BaseBlocState with _$RegisterUserInfoState {
  const factory RegisterUserInfoState() = _RegisterUserInfoState;
}
