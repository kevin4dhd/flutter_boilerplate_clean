import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'welcome_state.freezed.dart';

@freezed
class WelcomeState extends BaseBlocState with _$WelcomeState {
  const factory WelcomeState() = _WelcomeState;
}
