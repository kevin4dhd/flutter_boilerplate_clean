import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState extends BaseBlocState with _$AuthState {
  const factory AuthState() = _AuthState;
}
