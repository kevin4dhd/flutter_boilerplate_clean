import 'package:freezed_annotation/freezed_annotation.dart';

part 'pass_code_settings.freezed.dart';

@freezed
class PassCodeSettings with _$PassCodeSettings {
  factory PassCodeSettings({
    @Default('') String passCode,
    @Default(false) bool enabledBiometric,
  }) = _PassCodeSettings;
}
