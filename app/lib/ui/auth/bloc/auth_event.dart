import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'auth_event.freezed.dart';

abstract class AuthEvent extends BaseBlocEvent {
  const AuthEvent();
}

@freezed
class ClickOnCreate extends AuthEvent with _$ClickOnCreate {
  const factory ClickOnCreate() = _ClickOnCreate;
}

@freezed
class ClickOnImport extends AuthEvent with _$ClickOnImport {
  const factory ClickOnImport() = _ClickOnImport;
}
